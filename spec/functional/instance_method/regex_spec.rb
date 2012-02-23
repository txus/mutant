require 'spec_helper'

describe 'Mutating regexen' do
  context 'for an instance method' do
    context 'that contains `.*`' do
      before do
        write_file 'thing.rb', """
          class Thing
            def regex
              /.*/
            end
          end
        """
      end

      context 'with an expectation that a string matches the regex' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing#regex' do
              specify do
                'hello'.should match(Thing.new.regex)
              end
            end
          """
          mutate 'Thing#regex spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that the regex is a Regex' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing#regex' do
              specify { Thing.new.regex.should be_kind_of(Regexp) }
            end
          """
          mutate 'Thing#regex spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
