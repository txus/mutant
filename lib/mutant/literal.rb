module Mutant
  class Literal
    def self.literal_class(node)
      const_get(node.class.basename)
    end

    def initialize(node)
      @node = node
      @class = self.class.literal_class(node)
    end

    def swap
      @class.new(@node).swap
    end

    class BaseLiteral
      def initialize(node)
        @node = node
      end
    end

    class FalseLiteral < BaseLiteral
      def swap
        Rubinius::AST::TrueLiteral.new(@node.line)
      end
    end

    class TrueLiteral < BaseLiteral
      def swap
        Rubinius::AST::FalseLiteral.new(@node.line)
      end
    end

    class SymbolLiteral < BaseLiteral
      def swap
        @node.value = Random.symbol
        @node
      end
    end

    class StringLiteral < BaseLiteral
      def swap
        @node.string = Random.string
        @node
      end
    end

    class FixnumLiteral < BaseLiteral
      def swap
        @node.value = Random.fixnum
        @node
      end
    end

    class FloatLiteral < BaseLiteral
      def swap
        @node.value = Random.float
        @node
      end
    end

    class Range < BaseLiteral
      def swap
        range = Random.range
        @node.start = Rubinius::AST::FixnumLiteral.new(@node.line, range.min)
        @node.finish = Rubinius::AST::FixnumLiteral.new(@node.line, range.max)
        @node
      end
    end

    class RegexLiteral < BaseLiteral
      def swap
        @node.source = Regexp.escape(Random.string)
        @node
      end
    end

    class ArrayLiteral < BaseLiteral
      def swap
        @node.body = @node.body.reverse[1..-1]
        @node
      end
    end

    class HashLiteral < BaseLiteral
      def swap
        new_body = @node.array.each_slice(2).inject([]) do |body, (key, value)|
          new_value = literal_class(value).new(value.clone).swap

          body << key << new_value
        end

        @node.array = new_body
        @node
      end

      private

      def literal_class(value)
        Module.nesting[1].literal_class(value)
      end
    end

    class LocalVariableAssignment < BaseLiteral
      def swap
        @node.value = literal_class.new(@node.value.clone).swap
        @node
      end

      private

      def literal_class
        Module.nesting[1].literal_class(@node.value)
      end
    end

    class If < BaseLiteral
      def swap
        @node.body, @node.else = @node.else, @node.body
        @node
      end
    end
  end
end
