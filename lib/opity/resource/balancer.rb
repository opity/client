module Opity
  module Resource
    class Balancer < Base
      attribute :name
      attribute :type
      attribute :environment
      attribute :application

      def name
        "#{@data[:name]}-#{self.environment}-#{self.application}"
      end

      def list
        [self, Opity::Resource::Dns.new(name: self.name, type: 'dns')]
      end
    end
  end
end