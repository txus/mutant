require 'spec_helper'

describe 'Mutating string' do
  context 'for a singleton method' do
    context 'that contains "foo"' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.a_string
              'foo'
            end
          end
        """
      end

      context 'with an expectation that the return value is "foo"' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.a_string' do
              specify { Thing.a_string.should eq('foo') }
            end
          """
          run_simple '../../exe/mutate Thing.a_string spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the return value is a string' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.a_string' do
              specify { Thing.a_string.should be_a(String) }
            end
          """
          run_simple '../../exe/mutate Thing.a_string spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
