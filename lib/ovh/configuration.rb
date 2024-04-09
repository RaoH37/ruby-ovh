# frozen_string_literal: true

module Ovh
  class Application
    class Configuration
      attr_accessor :application_key, :application_secret, :consumer_key
      attr_reader :endpoint

      def initialize
        @endpoint = nil
        @application_key = nil
        @application_secret = nil
        @consumer_key = nil
      end

      def load_from_hash(hash)
        raise InvalidConfiguration, 'Invalid configuration hash' if hash.empty?

        self.endpoint = hash[:endpoint]
        @application_key = hash[:application_key]
        @application_secret = hash[:application_secret]
        @consumer_key = hash[:consumer_key]
      end

      def load_from_path(path)
        raise InvalidConfiguration, "no such file #{path}" unless File.exist?(path)

        hash = JSON.parse(File.read(path), symbolize_names: true)

        load_from_hash(hash)
      end

      def endpoint=(value)
        v_sym = value.to_sym
        raise InvalidEndpoint, "invalid endpoint #{v_sym}" if ENDPOINTS[v_sym].nil?

        @endpoint = v_sym
      end
    end
  end
end
