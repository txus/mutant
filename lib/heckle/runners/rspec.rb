require 'rspec/core'

module Heckle
  module Runners
    module RSpec
      def self.run(args, output)
        raise ::RSpec::Core::Runner.run(args, $stderr, output).inspect
        output.puts 'passed'
      end
    end
  end
end
