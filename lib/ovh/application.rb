# frozen_string_literal: true

module Ovh
  class Application
    def initialize
      yield(configuration) if block_given?
      @sha1 = OpenSSL::Digest.new('sha1')
      @time_delta = 0
    end

    def configuration(&block)
      @configuration ||= Configuration.new(&block)
    end

    def get(path, need_auth: true, headers: {})
      call(:get, path, need_auth:, headers:)
    end

    def put(path, data: {}, need_auth: true, headers: {})
      call(:put, path, data:, need_auth:, headers:)
    end

    def post(path, data: {}, need_auth: true, headers: {})
      call(:post, path, data:, need_auth:, headers:)
    end

    def delete(path, need_auth: true, headers: {})
      call(:delete, path, need_auth:, headers:)
    end

    def call(method, path, data: {}, need_auth: true, headers: {})
      raise InvalidHTTPMethod, "invalid http method #{method}" unless API_HTTP_METHODS.include?(method)

      ts = (Time.now.to_i + @time_delta).to_s
      url = compute_url(path)

      raise InvalidKey, 'ApplicationKey is required !' unless configuration.application_key

      headers['X-Ovh-Application'] = configuration.application_key

      if data.empty?
        body = ''
      else
        headers['Content-type'] = 'application/json'
        body = data.to_json
      end

      if need_auth
        raise InvalidKey, 'Consumer is required !' unless configuration.consumer_key

        headers['X-Ovh-Consumer'] = configuration.consumer_key
        headers['X-Ovh-Timestamp'] = ts
        headers['X-Ovh-Signature'] = compute_signature(method, url, body, ts)
      end

      do_request(method, url, body:, headers:)
    end

    def time_delta!
      server_ts = get('/auth/time', need_auth: false).to_i
      @time_delta = server_ts - Time.now.to_i
    end

    private

    def compute_signature(method, url, body, ts)
      concat = [configuration.application_secret, configuration.consumer_key, method.to_s.upcase, url, body, ts].join('+')
      hex = @sha1.hexdigest(concat)
      "$1$#{hex}"
    end

    def compute_url(path)
      endpoint = ENDPOINTS[configuration.endpoint].clone

      endpoint = endpoint[0..-5] if endpoint.end_with?('/1.0') && path.start_with?('/v1', '/v2')

      File.join(endpoint, path)
    end

    def do_request(method, url, body: nil, params: nil, headers: {})
      conn = Faraday.new(
        url:,
        headers:,
        request: {
          timeout: TIMEOUT
        }
      )

      response = conn.run_request(method, url, body, headers) do |request|
        request.params.update(params) if params
      end

      do_response(response)
    end

    def do_response(response)
      result = JSON.parse(response.body, symbolize_names: true)

      if response.status >= 100 && response.status < 300
        result
      elsif (response.status == 403) && (result[:errorCode] == 'NOT_GRANTED_CALL')
        raise NotGrantedCall, result[:message]
      elsif (response.status == 403) && (result[:errorCode] == 'NOT_CREDENTIAL')
        raise NotCredential, result[:message]
      elsif (response.status == 403) && (result[:errorCode] == 'INVALID_KEY')
        raise InvalidKey, result[:message]
      elsif (response.status == 403) && (result[:errorCode] == 'INVALID_CREDENTIAL')
        raise InvalidCredential, result[:message]
      elsif (response.status == 403) && (result[:errorCode] == 'FORBIDDEN')
        raise Forbidden, result[:message]
      elsif response.status == 404
        raise ResourceNotFoundError, result[:message]
      elsif response.status == 400
        raise BadParametersError, result[:message]
      elsif response.status == 409
        raise ResourceConflictError, result[:message]
      elsif response.status == 460
        raise ResourceExpiredError, result[:message]
      elsif response.status.zero?
        raise NetworkError
      else
        raise APIError, result[:message]
      end
    end
  end
end
