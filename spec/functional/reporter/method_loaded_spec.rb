require 'spec_helper'

describe 'Reporter' do
  describe 'method loaded' do
   context 'that has mutations' do
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
        mutate 'Thing#alive? spec/thing_spec.rb'
      end

      it 'displays the number of possible mutations' do
        all_output.should include <<-STR
**********************************************************************
***  Thing#alive? loaded with 1 possible mutation
**********************************************************************
STR
      end
    end

    context 'that has no mutations' do
      before do
        write_file 'thing.rb', """
          class Thing
            def alive?
            end
          end
        """
        write_file 'spec/thing_spec.rb', """
          require 'thing'

          describe 'Thing#alive?' do
            specify { Thing.new.alive?.should be_nil }
          end
        """
        mutate 'Thing#alive? spec/thing_spec.rb'
      end

      it 'displays a warning that there are no possible mutations' do
        all_output.should include <<-STR
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!  Thing#alive? has no possible mutations
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
STR
      end
    end
  end
end