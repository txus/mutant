require 'spec_helper'

describe 'Mutating booleans' do
  context 'for a singleton method' do
    context 'that contains `true`' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.alive?
              true
            end
          end
        """
      end

      context 'with an expectation that the return value is true' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'
            
            describe 'Thing.alive?' do
              specify { Thing.should be_alive }
            end
          """
          run_simple '../../bin/mutate spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the return value is true or false' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'
            
            describe 'Thing.alive?' do
              specify { String(Thing.alive?).should =~ /true|false/ }
            end
          """
          run_simple '../../bin/mutate spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
