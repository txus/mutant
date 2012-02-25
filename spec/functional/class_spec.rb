require 'spec_helper'

describe 'Mutating a class' do
  before do
    write_file 'thing.rb', """
      class Thing
        def alive?; true end
        def dead?; false end
        def mood; :happy end
        def gender; 'male' end
        def alphabet_range; 'a'..'k' end
      end
    """
    write_file 'spec/thing_spec.rb', """
      $: << '.'
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

        describe '#alphabet_range' do
          specify { Thing.new.alphabet_range.should eq('a'..'k') }
        end
      end
    """
    mutate 'Thing spec/thing_spec.rb'
  end

  it 'runs all possible mutations' do
    all_output.should include('passed')
  end
end
