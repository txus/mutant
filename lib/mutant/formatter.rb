require 'to_source'

module Mutant
  class Formatter
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def nested?
      false
      # item.is_a?(Rubinius::AST::LocalVariableAssignment) ||
      #   item.is_a?(Rubinius::AST::HashLiteral) ||
      #   item.is_a?(Rubinius::AST::If)
    end

    def to_s
      item.to_source
    end
  end
end
