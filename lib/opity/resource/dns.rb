module Opity
  module Resource
    class Dns < Base
      attribute :name
      attribute :type
      attribute :environment
      attribute :application

      attribute :ttl, default: 60
    end
  end
end