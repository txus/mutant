module Mutant
  module Rbx
    class Mutatee
      extend Forwardable

      attr_reader :implementation

      def initialize(implementation)
        @implementation = implementation
      end

      def_delegators :@implementation, :class_name, :method_name, :to_s

      def rbx_method
        @rbx_method ||=
          case implementation.scope_type
          when :singleton
            SingletonMethod.new(
              implementation.constant.method(method_name)
            )
          when :instance
            InstanceMethod.new(
              implementation.constant.instance_method(method_name)
            )
          end
      end
    end
  end
end
