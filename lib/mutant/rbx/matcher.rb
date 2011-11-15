module Mutant
  module Rbx
    class Matcher
      attr_reader :method
      
      def self.match(implementation)
        yield new(implementation)
      end

      def initialize(implementation)
        @implementation = implementation
        @method = instantiate_method
      end

      def method_class
        @implementation.split(/\.|#/)[0].to_sym
      end

      def instantiate_method
        case @implementation
        when /(.+)#(.+)/
          InstanceMethod.new(Object.const_get($1).instance_method($2))
        when /(.+)\.(.+)/
          SingletonMethod.new(Object.const_get($1).method($2))
        end
      end
    end
  end
end
