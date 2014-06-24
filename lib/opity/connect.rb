module Opity
  class Connect
    def initialize
      options = Opity.options
      providers = Opity.providers
      @connections = {
          balancer: nil,
          compute: nil,
          dns: nil,
      }
      providers.each do |p|
        name = p.name
        type = p.type.to_sym
        data = Opity.secrets_for(name)
        # @connections[type] = {key: key, secret: secret}
        @connections[type] = self.class.connect!(type, data)
      end
    end

    def method_missing(method, *args, &block)
      get(method)
    end

    def [](type)
      get(type)
    end

    def get(type)
      m = type.to_sym
      raise "unknown connection type: #{m}" unless @connections[m]
      @connections[m]
    end


    class << self
      def instance
        @instance ||= self.new
      end

      def connect!(type, options)
        klass = case type.to_sym
                  when :compute
                    Fog::Compute
                  when :balancer
                    Fog::Balancer
                  when :dns
                    Fog::DNS
                end
        klass.new(options)
      end
    end
  end
end