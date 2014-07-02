require 'hashie'
require 'yaml'
require 'active_support/all'

require 'require_all'
require_rel 'opity'
require 'fog'
require_rel 'fog'

module Opity
  class << self
    attr_accessor :configfile
    attr_accessor :secretsfile

    def secrets
      @secrets ||= begin
        data = loadfile(@secretsfile)
        raise "secrets must have root opity key" unless data['opity']
        Hashie::Mash.new(data['opity'])
      end
    end

    def config
      @config ||= begin
        data = loadfile(@configfile)
        raise "config must have root opity key" unless data['opity']
        Opity::Config.new(data['opity'])
      end
    end

    def connect
      Opity::Connect.instance
    end

    def secrets_for(name)
      secrets[name]
    end

    def providers
      options.providers
    end

    def options
      config.options
    end

    def domain
      options.domain
    end

    def environment(name)
      environments.detect{|e| e.name == name}
    end

    def environments
      config.environments
      # @environments ||= begin
      #   list = config.environments
      #   list.inject({}) do |h, e|
      #     puts "E:#{e.name} #{e.inspect}"
      #     h[e.name] = e
      #     # h = v.to_hash
      #     # h['application'] = options['application']
      #     # Opity::Environment.new(k, h)
      #     h
      #   end
      # end
    end

    def check
      # validate
      # * configuration and secrets files are formatted correctly
      # * providers that are being used have entries in the secrets file
      raise "not implemented"
    end

    def reset!
      @secrets = nil
      @config = nil
    end

    private

    def loadfile(file)
      f = File.expand_path(file)
      raise "file #{file} not found" unless File.exists?(f)
      YAML.load_file(f)
    end
  end
end

Opity.configfile = './.opity.yml'
Opity.secretsfile = '~/.opity.secrets'
