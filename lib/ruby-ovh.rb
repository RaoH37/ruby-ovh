# frozen_string_literal: true

require 'faraday'
require 'logger'
require 'openssl'

module Ovh
  class << self
    def version
      VERSION::STRING
    end

    def logger
      @logger || logger!
    end

    def logger!(path = $stdout)
      @logger = Logger.new(path)
      @logger.level = Logger::INFO
      @logger.formatter = proc do |severity, datetime, _progname, msg|
        "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} #{severity} - #{msg}\n"
      end
      @logger
    end

    attr_writer :logger
  end
end

require_relative 'ovh/constants'
require_relative 'ovh/application'
require_relative 'ovh/configuration'
require_relative 'ovh/version'
require_relative 'ovh/errors'
