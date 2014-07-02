require 'colorize'

module Opity
  class Status
    def initialize
      @resources = {}
    end

    def add(resource)
      k = "#{resource.type}:#{resource.name}"
      raise "resource name already in use: #{k}" if @resources[k]
      @resources[k] = {status: resource.valid?, resource: resource}
    end

    def to_s
      str = ""
      @resources.each do |k, e|
        b = e[:status] ? 'x' : ''
        r = e[:resource]
        n = r.name
        t = r.type
        o = r.options_string
        str += "  %1.1s %-10.10s %-30.30s %s\n" % [b, t, n, o]
      end
      str
    end

    def color_to_s
      str = ""
      @resources.each do |k, e|
        r = e[:resource]
        n = r.fullname
        t = r.type
        o = r.options_string
        s = "  %-10.10s %-30.30s %s\n" % [t, n, o]
        str += e[:status] ? s.colorize(:green) : s.colorize(:red)
      end
      str
    end

    def to_hash
      @resources
    end
  end
end
