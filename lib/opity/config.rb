require 'active_support/all'

module Opity
  class Config < Model
    attribute :options, type: :hash
    has_many :resources
    has_many :environments
    has_many :providers
    child :options, klass: Opity::Options

    def initialize(data)
      data = data.deep_stringify_keys
      res = data.delete('resources')
      env = data.delete('environments')
      opt = data.delete('options')
      super(data)
      if opt
        self.options = Opity::Options.new(opt)
      end
      if res && res.count > 0
        res.each do |resource|
          resource[:application] = opt['application']
          self.resources << Opity::Resource.new(resource)
        end
      end
      if env && env.count > 0
        env.each do |name, environment|
          environment[:application] = opt['application']
          self.environments << Opity::Environment.new(name, environment)
        end
      end
    end

    def resource_list
      out = []
      self.resources.each do |r|
        out << r.list
      end
      out.flatten
    end
  end
end
