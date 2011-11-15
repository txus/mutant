require 'mutant/rbx/matcher'
require 'mutant/rbx/method'
require 'mutant/rbx/mutator'

module Mutant
  module Rbx
    def self.mutate(implementation)
      Matcher.match(implementation) do |match|
        Mutator.new(match).mutate
      end
    end
  end
end
