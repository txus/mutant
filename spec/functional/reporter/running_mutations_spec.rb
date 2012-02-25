require 'spec_helper'

describe 'Reporter' do
  describe 'running mutations' do
    before do
      write_file 'thing.rb', <<-CODE
class Thing
  def alive?
    a_string = 'foo'
    a_symbol = :bar
    a_range = 'a'..'c'
    :symbol
    true
  end
end
CODE
      write_file 'spec/thing_spec.rb', """
        $: << '.'
        require 'thing'

        describe 'Thing#alive?' do
          specify { Thing.new.should be_alive }
        end
      """

      ENV['RANDOM_STRING'] = 'bar'
      ENV['RANDOM_SYMBOL'] = 'foo'
      ENV['RANDOM_RANGE_MIN'] = '1'
      ENV['RANDOM_RANGE_MAX'] = '3'

      run_simple '../../bin/mutate Thing#alive? spec/thing_spec.rb'
    end

    after do
      ENV['RANDOM_STRING'] = nil
      ENV['RANDOM_SYMBOL'] = nil
      ENV['RANDOM_RANGE_MIN'] = nil
      ENV['RANDOM_RANGE_MAX'] = nil
    end

    it 'displays the details of each mutation as they are run' do
      all_output.should include <<-STR
Mutating line 3
  a_string = "foo" >>>
  a_string = "bar"

Mutating line 4
  a_symbol = :bar >>>
  a_symbol = :foo

Mutating line 5
  a_range = "a".."c" >>>
  a_range = 1..3

Mutating line 6
  :symbol >>> :foo

Mutating line 7
  true >>> false
STR
    end
  end
end
