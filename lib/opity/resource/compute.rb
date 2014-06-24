module Opity
  module Resource
    class Compute < Base
      attribute :name
      attribute :type
      attribute :total, default: 1
      attribute :balancer, default: nil
      has_many :roles
    end
  end
end