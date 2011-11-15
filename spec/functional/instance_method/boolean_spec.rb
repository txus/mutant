require 'spec_helper'

describe 'Mutating booleans' do
  context 'for an instance method' do
    context 'that contains `true`' do
      before do
        write_file 'thing.rb', """
          class Thing
            def alive?
              true
            end
          end
        """
      end

      context 'with an expectation that the return value is true' do
        before do
          write_file 'spec/thing_spec_1.rb', """
            require 'thing'
            
            describe 'Thing#alive?' do
              specify { Thing.new.should be_alive }
            end
          """
          run_simple '../../bin/mutate Thing#alive? spec/thing_spec_1.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the return value is true or false' do
        before do
          write_file 'spec/thing_spec_2.rb', """
            require 'thing'
            
            describe 'Thing#alive?' do
              specify { String(Thing.new.alive?).should =~ /true|false/ }
            end
          """
          run_simple '../../bin/mutate Thing#alive? spec/thing_spec_2.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end

    context 'that contains `false`' do
      before do
        write_file 'thing.rb', """
          class Thing
            def alive?
              false
            end
          end
        """
      end

      context 'with an expectation that the return value is false' do
        before do
          write_file 'spec/thing_spec_1.rb', """
            require 'thing'
            
            describe 'Thing.alive?' do
              specify { Thing.new.should_not be_alive }
            end
          """
          run_simple '../../bin/mutate Thing#alive? spec/thing_spec_1.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the return value is true or false' do
        before do
          write_file 'spec/thing_spec_2.rb', """
            require 'thing'
            
            describe 'Thing#alive?' do
              specify { String(Thing.new.alive?).should =~ /true|false/ }
            end
          """
          run_simple '../../bin/mutate Thing#alive? spec/thing_spec_2.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
