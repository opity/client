require "opity/version"
require 'opity/config'
require 'yaml'
require 'active_support/all'

module Opity
  class << self
    attr_accessor :environment

    def config(file="./.opity.yml")
      @config ||= begin
        data = File.exist?(file) ? YAML.load_file(file) : {}
        raise "config must have root opity key" unless data['opity']
        Opity::Config.new(data['opity'])
      end
    end

    def environment
      @environment || 'development'
    end
  end
end
