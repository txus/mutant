require 'spec_helper'

describe 'Mutating ranges' do
  context 'for a singleton method' do
    context 'that contains a..z' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.a_range
              'a'..'z'
            end
          end
        """
      end

      context "with an expectation that the return value is `'a'..'z'`" do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing#a_range' do
              specify { Thing.a_range.should eq('a'..'z') }
            end
          """
          run_simple '../../bin/mutate Thing.a_range spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context "with an expectation that the return value is a range" do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.a_string' do
              specify { Thing.a_range.should be_a(Range) }
            end
          """
          run_simple '../../bin/mutate Thing.a_range spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end