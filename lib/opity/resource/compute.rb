module Opity
  module Resource
    class Compute < Base
      attribute :name
      attribute :type
      attribute :environment
      attribute :application
      attribute :total, default: 1
      attribute :balancer, default: nil
      has_many :roles
      attribute :create, default: true

      def list
        out = []
        1.upto(total) do |i|
          newdata = @data.dup
          newdata[:name] = newdata[:name] + ('%02d' % i)
          newdata[:num] = i
          newdata.delete(:total)
          out << self.class.new(newdata)
          out << Opity::Resource::Dns.new(name: "#{newdata[:name]}-#{self.environment}-#{self.application}", type: 'dns')
        end
        out
      end

      def options
        options = super
        options.delete(:total)
        options
      end

      def valid?
        # x = Opity.connect.compute
        # ! x.servers.all({"tag:Name" => name}).nil?
        c = self.class.computes.detect {|e| e.tags['Name'] == name}
        return false unless c
        true
      end

      class << self
        def computes
          @computes ||= begin
            x = Opity.connect.compute
            x.servers.all
          end
        end
      end
    end
  end
end
