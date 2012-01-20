require 'mutant/rbx/method'
require 'mutant/rbx/mutatee'
require 'mutant/rbx/mutation'
require 'mutant/rbx/mutator'
require 'mutant/rbx/node'

module Mutant
  module Rbx
    def self.mutate(implementation)
      implementation.mutatees.each do |mutatee|
        Mutator.new(mutatee).mutate
      end
    end
  end
end
