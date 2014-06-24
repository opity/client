module Opity
  class Environment < Model
    attribute :name
    has_many :resources

    def initialize(name, data)
      res = data.delete(:resources) || data.delete('resources')
      super(data)
      self.name = name
      if res && res.count > 0
        res.each do |resource|
          self.resources << Opity::Resource.new(resource)
        end
      end
    end
  end
end