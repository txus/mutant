require 'mutant/version'

module Mutant
  module Runners
    autoload :RSpec, 'mutant/runners/rspec'
  end

  def self.run(args)
    Runners::RSpec.run(args)
  end
end
