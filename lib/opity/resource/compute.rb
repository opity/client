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
    end
  end
end