require 'spec_helper'

describe 'Mutating booleans' do
  context 'for a singleton method' do
    context 'that contains `true`' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.type
              true
            end
          end
        """
      end

      context 'with an expectation that the return value is true' do
        before do
          write_file 'spec/thing_spec.rb', """
            describe 'Thing.type' do
              specify { Thing.type.should be_true }
            end
          """
          Mutant::Runners::RSpec.run(output)
        end

        specify 'the mutation passes' do
          output.string.should include('passed')
        end
      end

      context 'with an expectation that the return value is true or false' do
        before do
          write_file 'spec/thing_spec.rb', """
            describe 'Thing.type' do
              specify { String(Thing.type).should =~ /true|false/ }
            end
          """
          run_simple '../../bin/mutate'
        end

        specify 'the mutation fails', :focus do
          all_output.should include('failed')
        end
      end
    end
  end
end
