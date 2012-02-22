require 'spec_helper'

describe 'Mutating regexen' do
  context 'for a singleton method' do
    context 'that contains `.*`' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.regex
              /.*/
            end
          end
        """
      end

      context 'with an expectation that a string matches the regex' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.regex' do
              specify do
                'hello'.should match(Thing.regex)
              end
            end
          """
          run_simple '../../bin/mutate Thing.regex spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the regex is a Regexp' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.regex' do
              specify { Thing.regex.should be_kind_of(Regexp) }
            end
          """
          run_simple '../../bin/mutate Thing.regex spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
