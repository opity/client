module Opity
  module Resource
    class Dns < Base
      attribute :name
      attribute :type
      attribute :environment
      attribute :application
      attribute :create, default: true

      attribute :ttl, default: 60

      def valid?
        d = Opity.options['domain']
        n = "#{self.name}.#{d}"
        r = self.class.records.detect { |e| e.name == n }
        return false if r.nil?
        true
      end

      def fullname
        name
      end

      class << self
        def records
          @records ||= begin
            zone.records
          end
        end

        def zone
          @zone ||= begin
            x = Opity.connect.dns
            d = Opity.domain
            x.zones.all.detect { |e| e.domain == d }
          end
        end
      end
    end
  end
end
