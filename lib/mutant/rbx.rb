require 'mutant/rbx/method'
require 'mutant/rbx/mutatee'
require 'mutant/rbx/mutator'

module Mutant
  module Rbx
    def self.mutate(implementation)
      implementation.mutatees.each do |mutatee|
        Mutator.new(mutatee).mutate
      end
    end
  end
end
