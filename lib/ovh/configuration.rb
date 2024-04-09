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

      def endpoint=(value)
        raise InvalidEndpoint, "invalid endpoint #{value}" if ENDPOINTS[value].nil?

        @endpoint = value
      end
    end
  end
end
