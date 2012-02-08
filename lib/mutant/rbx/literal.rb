module Mutant
  module Rbx
    class Literal
      def self.literal_class(node)
        const_get(node.class.name.split('::').last)
      end

      def initialize(node)
        @node = node
        @class = self.class.literal_class(node)
      end

      def swap
        @class.new(@node).swap
      end

      class Base
        def initialize(node)
          @node = node
        end
      end

      class FalseLiteral < Base
        def swap
          Rubinius::AST::TrueLiteral.new(@node.line)
        end
      end

      class TrueLiteral < Base
        def swap
          Rubinius::AST::FalseLiteral.new(@node.line)
        end
      end

      class SymbolLiteral < Base
        def swap
          @node.value = Random.symbol
          @node
        end
      end

      class StringLiteral < Base
        def swap
          @node.string = Random.string
          @node
        end
      end

      class Range < Base
        def swap
          range = Random.range
          @node.start = Rubinius::AST::FixnumLiteral.new(@node.line, range.min)
          @node.finish = Rubinius::AST::FixnumLiteral.new(@node.line, range.max)
          @node
        end
      end

      class LocalVariableAssignment < Base
        def swap
          @node.value = literal_class.new(@node.value.clone).swap
          @node
        end

        private

        def literal_class
          Module.nesting[1].literal_class(@node.value)
        end
      end
    end
  end
end