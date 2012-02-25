require 'to_source'

module Mutant
  class Formatter
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def nested?
      false
    end

    def to_s
      item.to_source
    end
  end
end
