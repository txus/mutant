require 'mutant/formatter'
require 'mutant/implementation'
require 'mutant/literal'
require 'mutant/method'
require 'mutant/mutatee'
require 'mutant/mutation'
require 'mutant/mutator'
require 'mutant/node'
require 'mutant/random'
require 'mutant/reporter'
require 'mutant/version'

module Mutant
  module Runners
    autoload :RSpec, 'mutant/runners/rspec'
  end

  def self.run(args)
    Runners::RSpec.run(args)
  end

  def self.mutate(implementation)
    implementation.mutatees.each do |mutatee|
      Mutator.new(mutatee).mutate
    end
  end
end
