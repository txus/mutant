require 'spec_helper'

describe 'Mutating floats' do
  context 'for an instance method' do
    context 'that contains 42.5' do
      before do
        write_file 'life.rb', """
          class Life
            def answer
              42.5
            end
          end
        """
      end

      context 'with an expectation that the return value is 42.5' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.answer.should eq(42.5) }
            end
          """
          run_simple '../../bin/mutate Life#answer spec/life_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the return value is a Float' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.answer.should be_a(Float) }
            end
          """
          run_simple '../../bin/mutate Life#answer spec/life_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
