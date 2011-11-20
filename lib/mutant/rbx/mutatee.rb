module Mutant
  module Rbx
    class Mutatee
      def initialize(_class, scope, _method)
        @_class, @scope, @_method = _class, scope, _method
      end

      def _class
        Object.const_get(@_class)
      end

      def _method
        @rbx_method ||=
          case @scope
          when /#/  then InstanceMethod.new(_class.instance_method(@_method))
          when /\./ then SingletonMethod.new(_class.method(@_method))
          end
      end
    end
  end
end
