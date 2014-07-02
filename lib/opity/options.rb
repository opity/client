module Opity
  class Options < Model
    attribute :version
    attribute :application
    attribute :domain
    has_many :providers

    def initialize(data={})
      data = data.deep_stringify_keys
      pro = data.delete('providers')
      super(data)
      if pro && pro.count > 0
        pro.each do |provider|
          self.providers << Hashie::Mash.new(provider)
        end
      end
    end
  end
end
