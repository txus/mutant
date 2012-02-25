require 'spec_helper'

describe 'Mutating calls' do
  context 'for an instance method' do
    context 'that contains a method call without arguments' do
      before do
        write_file 'life.rb', """
          class Life
            def helper
              42
            end

            def answer
              helper
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

      context 'with an expectation that life respond to :answer' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.should respond_to(:answer) }
            end
          """
          run_simple '../../bin/mutate Life#answer spec/life_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end

    context 'that contains a method call with arguments' do
      before do
        write_file 'life.rb', """
          class Life
            def helper(num)
              num + 2
            end

            def answer
              helper(40)
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

      context 'with an expectation that life respond to :answer' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.should respond_to(:answer) }
            end
          """
          run_simple '../../bin/mutate Life#answer spec/life_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end

    context 'that contains a method call with a block' do
      before do
        write_file 'life.rb', """
          class Life
            def helper
              yield
            end

            def answer
              helper { 42 }
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

      context 'with an expectation that life respond to :answer' do
        before do
          write_file 'spec/life_spec.rb', """
            $: << '.'
            require 'life'

            describe 'Life#answer' do
              specify { Life.new.should respond_to(:answer) }
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
