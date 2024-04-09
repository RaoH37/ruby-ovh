# frozen_string_literal: true

module Ovh
  class HTTPError < StandardError; end

  class APIError < StandardError; end

  class InvalidHTTPMethod < StandardError; end

  class InvalidEndpoint < StandardError; end

  class InvalidKey < StandardError; end

  class InvalidCredential < StandardError; end

  class InvalidResponse < StandardError; end

  class InvalidRegion < StandardError; end

  class ReadOnlyError < StandardError; end

  class ResourceNotFoundError < StandardError; end

  class BadParametersError < StandardError; end

  class ResourceConflictError < StandardError; end

  class NetworkError < StandardError; end

  class NotGrantedCall < StandardError; end

  class NotCredential < StandardError; end

  class Forbidden < StandardError; end

  class ResourceExpiredError < StandardError; end
end
