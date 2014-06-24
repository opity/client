module Opity
  class Environment < Model
    attribute :name
    attribute :application
    has_many :resources

    def initialize(name, data)
      res = data.delete(:resources) || data.delete('resources')
      super(data)
      self.name = name
      if res && res.count > 0
        res.each do |resource|
          resource[:environment] = self.name
          resource[:application] = self.application
          self.resources << Opity::Resource.new(resource)
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