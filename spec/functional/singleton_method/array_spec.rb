require 'spec_helper'

describe 'Mutating arrays' do
  context 'for a singleton method' do
    context 'that contains [1,2,3]' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.to_a
              [1,2,3]
            end
          end
        """
      end

      context 'with an expectation that the array is [1,2,3]' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.to_a' do
              specify { Thing.to_a.should eq([1,2,3]) }
            end
          """
          run_simple '../../exe/mutate Thing.to_a spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the array responds to length' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.to_a' do
              specify { Thing.to_a.should respond_to(:length) }
            end
          """
          run_simple '../../exe/mutate Thing.to_a spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
