module Opity
  module Resource
    class Balancer < Base
      attribute :name
      attribute :type
      attribute :environment
      attribute :application

      def list
        [self, Opity::Resource::Dns.new(name: self.name, type: 'dns')]
      end

      def valid?
        b = self.class.balancers.detect {|e| e.id == name}
        return false if b.nil?
        true
      end

      class << self
        def balancers
          @balancers ||= begin
            x = Opity.connect.balancer
            x.load_balancers
          end
        end
      end
    end
  end
end