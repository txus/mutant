module Mutant
  class Formatter
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def nested?
      item.is_a?(Rubinius::AST::LocalVariableAssignment)
    end

    def to_s
      if item.is_a?(Rubinius::AST::LocalVariableAssignment)
        [item.name.to_s, item_value].join(' = ')
      else
        if item.is_a?(Rubinius::AST::TrueLiteral)
          'true'
        elsif item.is_a?(Rubinius::AST::FalseLiteral)
          'false'
        else
          item_value(item)
        end
      end
    end

    private

    def item_value(value = item.value)
      case value
      when Rubinius::AST::Range
        Range.new(item_value(value.start), item_value(value.finish))
      when Rubinius::AST::RegexLiteral
        Regexp.new(value.source)
      else
        value.respond_to?(:string) ? value.string.inspect : value.value.inspect
      end
    end
  end
end
