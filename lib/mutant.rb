require 'mutant/version'
require 'mutant/implementation'
require 'mutant/rbx'
require 'mutant/reporter'
require 'mutant/support/random'

module Mutant
  module Runners
    autoload :RSpec, 'mutant/runners/rspec'
  end

  def self.run(args)
    Runners::RSpec.run(args)
  end
end
