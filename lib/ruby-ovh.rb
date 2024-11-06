# frozen_string_literal: true

require 'logger'

module Ovh
  class << self
    attr_writer :logger

    def version = File.read(File.expand_path('../OVH_VERSION', __dir__)).strip

    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.level = Logger::INFO
        log.formatter = proc do |severity, datetime, _progname, msg|
          "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} #{severity} - #{msg}\n"
        end
      end
    end
  end
end

require_relative 'ovh/constants'
require_relative 'ovh/application'
require_relative 'ovh/configuration'
require_relative 'ovh/errors'
