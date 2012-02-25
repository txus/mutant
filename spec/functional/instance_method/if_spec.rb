require 'spec_helper'

describe 'Mutating If clauses' do
  context 'for an instance method' do
    context 'that contains an if-else that returns 42' do
      before do
        write_file 'life.rb', """
          class Life
            def answer
              if true
                42
              else
                24
              end
            end
          end
        """
      end

      context 'with an expectation that the answer is 42' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.answer.should eq(42) }
            end
          """
          run_simple '../../bin/mutate Life#answer spec/life_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the answer is a Fixnum' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.answer.should be_kind_of(Fixnum) }
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
