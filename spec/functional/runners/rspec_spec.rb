require 'spec_helper'

describe 'Runners' do
	describe 'RSpec' do
		describe 'a spec that fails before mutations' do
			before do
        write_file 'spec/thing_spec.rb', """
          class Thing
            def alive?; true end
          end

          describe 'Thing#alive?' do
            specify { Thing.new.should_not be_alive }
          end
        """
        run_simple '../../bin/mutate Thing#alive? spec/thing_spec.rb', false
      end

			it 'causes the run to abort' do
				all_output.should include(
					'Initial run of specs failed... fix and run mutant again'
				)
			end
		end
	end
end