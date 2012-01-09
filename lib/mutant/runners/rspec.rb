require 'rspec/core'

module Mutant
  module Runners
    class RSpec
      ABORT_MESSAGE = 'Initial run of specs failed... fix and run mutant again'

      def self.run(args)
        runner = new(args)
        runner.initial_run
        runner.mutate
        puts runner.run.zero? ? 'failed' : 'passed'
      end

      def initialize(args)
        @implementation = Implementation.new(args.shift)
        @args = args
      end

      def initial_run
        abort ABORT_MESSAGE unless run.zero?
      end

      def run
        ::RSpec::Core::Runner.run(@args)
      end

      def mutate
        Rbx.mutate(@implementation)
      end
    end
  end
end

