module Mutant
  class Mutation
    extend Forwardable

    attr_reader :array

    def initialize(node, array)
      @node = node
      @array = array
      @mutated = false
    end

    def_delegators :@node, :line, :from, :to, :mutatable?

    def mutated?
      @mutated
    end

    def mutate
      @array[@array.index(@node.item)] = @node.swap
      @mutated = true
    end
  end
end
