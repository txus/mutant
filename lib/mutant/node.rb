module Mutant
  class Node
    attr_reader :item, :copy

    def initialize(item)
      @item = item
      @copy = item.clone
    end

    def line
      item.line
    end

    def from
      @from ||= Formatter.new(item)
    end

    def to
      @to ||= Formatter.new(copy)
    end

    def swap
      @copy = Literal.new(copy).swap
    end

    def mutatable?
      Literal.new(@copy).changes_on_swap?
    end
  end
end
