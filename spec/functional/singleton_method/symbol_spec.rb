require 'spec_helper'

describe 'Mutating symbols' do
  context 'for a singleton method' do
    context 'that contains :foo' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.a_symbol
              :foo
            end
          end
        """
      end

      context 'with an expectation that the return value is :foo' do
        before do
          write_file 'spec/thing_spec_1.rb', """
            require 'thing'

            describe 'Thing.a_symbol' do
              specify { Thing.a_symbol.should eq(:foo) }
            end
          """
          run_simple '../../bin/mutate Thing.a_symbol spec/thing_spec_1.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the return value is not :foo' do
        before do
          write_file 'spec/thing_spec_2.rb', """
            require 'thing'

            describe 'Thing.a_symbol' do
              specify { Thing.a_symbol.should_not eq(:foo) }
            end
          """
          run_simple '../../bin/mutate Thing.a_symbol spec/thing_spec_2.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
