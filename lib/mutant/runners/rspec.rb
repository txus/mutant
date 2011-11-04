require 'rspec/core'

module Mutant
  module Runners
    module RSpec
      def self.run(args)
        passed = ::RSpec::Core::Runner.run(args)
        puts passed ? 'passed' : 'failed'
      end
    end
  end
end
