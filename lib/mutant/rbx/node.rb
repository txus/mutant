module Mutant
  module Rbx
    class Node
      attr_reader :item

      def initialize(item)
        @item = item
        @copy = item.clone
      end

      def line
        @item.line
      end

      def from
        @from ||= Formatter.new(@item)
      end

      def to
        @to ||= Formatter.new(@copy)
      end

      def swap
        case @copy
        when Rubinius::AST::TrueLiteral
          @copy = Rubinius::AST::FalseLiteral.new(@copy.line)
        when Rubinius::AST::FalseLiteral
          @copy = Rubinius::AST::TrueLiteral.new(@copy.line)
        when Rubinius::AST::SymbolLiteral
          @copy.value = Random.symbol
        when Rubinius::AST::StringLiteral
          @copy.string = Random.string
        when Rubinius::AST::Range
          range = Random.range
          @copy.start = if range.min.is_a?(String)
            Rubinius::AST::StringLiteral.new(@copy.line, range.min)
          else
            Rubinius::AST::FixnumLiteral.new(@copy.line, range.min)
          end
          @copy.finish = if range.max.is_a?(String)
            Rubinius::AST::StringLiteral.new(@copy.line, range.max)
          else
            Rubinius::AST::FixnumLiteral.new(@copy.line, range.max)
          end
        when Rubinius::AST::LocalVariableAssignment
          @copy.value = self.class.new(@copy.value).swap
        else
          raise "Need to swap #{@item.inspect}"
        end
        @copy
      end

      class Formatter
        def initialize(item)
          @item = item
        end

        def nested?
          @item.is_a?(Rubinius::AST::LocalVariableAssignment)
        end

        def to_s
          if @item.is_a?(Rubinius::AST::LocalVariableAssignment)
            [@item.name.to_s, item_value].join(' = ')
          else
            if @item.is_a?(Rubinius::AST::TrueLiteral)
              'true'
            elsif @item.is_a?(Rubinius::AST::FalseLiteral)
              'false'
            else
              item_value(@item)
            end
          end
        end

        private

        def item_value(value = @item.value)
          case value
          when Rubinius::AST::Range
            Range.new(item_value(value.start), item_value(value.finish))
          else
            value.respond_to?(:string) ? value.string.inspect : value.value.inspect
          end
        end
      end
    end
  end
end
