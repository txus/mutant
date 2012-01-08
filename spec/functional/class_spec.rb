require 'spec_helper'

describe 'Mutating a class' do
  before do
    write_file 'thing.rb', """
      class Thing
        def alive?; true end
        def dead?; false end
        def mood; :happy end
        def gender; 'male' end
      end
    """
    write_file 'spec/thing_spec.rb', """
      require 'thing'

      describe Thing do
        describe '#alive?' do
          specify { Thing.new.should be_alive }
        end

        describe '#dead?' do
          specify { Thing.new.should_not be_dead }
        end

        describe '#mood' do
          specify { Thing.new.mood.should eq(:happy) }
        end

        describe '#gender' do
          specify { Thing.new.gender.should eq('male') }
        end
      end
    """
    run_simple '../../bin/mutate Thing spec/thing_spec.rb'
  end

  it 'runs all possible mutations' do
    all_output.should include('passed')
  end
end
