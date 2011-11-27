require 'spec_helper'

describe 'Mutating a class' do
  before do
    write_file 'thing.rb', """
      class Thing
        def alive?
          true
        end
      end
    """
    write_file 'spec/thing_spec.rb', """
      require 'thing'
            
      describe 'Thing#alive?' do
        specify { Thing.new.should be_alive }
      end
    """
    run_simple '../../bin/mutate Thing spec/thing_spec.rb'
  end

  it 'runs all possible mutations' do
    all_output.should include('passed')
  end
end
