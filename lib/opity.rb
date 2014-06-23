require 'hashie'
require 'yaml'
require 'active_support/all'

require 'opity/version'
require 'opity/config'
require 'opity/environment'

module Opity
  class << self
    def secrets(file=File.expand_path("~/.opity.secrets"))
      @secrets ||= begin
        data = File.exist?(file) ? YAML.load_file(file) : {}
        raise "secrets must have root opity key" unless data['opity']
        Opity::Config.new(data['opity'])
      end
    end

    def config(file="./.opity.yml")
      @config ||= begin
        data = File.exist?(file) ? YAML.load_file(file) : {}
        raise "config must have root opity key" unless data['opity']
        Opity::Config.new(data['opity'])
      end
    end

    def environment(name)
      environments[name]
    end

    def environments
      list = config['environments']
      list.map {|k, v| Opity::Environment.new(v)}
    end

    def check
      # validate
      # * configuration and secrets files are formatted correctly
      # * providers that are being used have entries in the secrets file
      raise "not implemented"
    end
  end
end
