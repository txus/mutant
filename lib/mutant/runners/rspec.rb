require 'rspec/core'

module Mutant
  module Runners
    class RSpec
      def self.run(args)
        runner = new(args)
        runner.run
        runner.mutate
        puts runner.run.zero? ? 'failed' : 'passed'
      end

      def initialize(args)
        @implementation = args.shift
        @args = args
      end

      def mutate
        Rbx.mutate(@implementation)
      end

      def run
        ::RSpec::Core::Runner.run(@args)
      end
    end
  end
end

