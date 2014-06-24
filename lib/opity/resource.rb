module Opity
  module Resource
    class << self
      def new(data)
        type = data[:type] || data['type']
        begin
          name = "Opity::Resource::#{type.capitalize}"
          klass = name.constantize
          klass.new(data)
        rescue => e
          puts e.message
          puts e.backtrace.first(5).join("\n")
          raise "could not find class #{name}: #{e.message}"
        end
      end
    end

    class Base < Model
      attribute :name
      attribute :type

      def options
        opts = @data.dup
        opts.delete(:name)
        opts.delete(:type)
        opts.delete(:cloud)
        opts
      end

      def list
        [self]
      end
    end
  end
end