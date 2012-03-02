require 'spec_helper'

describe 'Mutating hashes' do
  context 'for an instance method' do
    context 'that contains {}' do
      before do
        write_file 'thing.rb', """
          class Thing
            def to_hash
              {}
            end
          end
        """
      end

      context 'with an expectation that the method returns {}' do
        before do
          write_file 'spec/thing_spec.rb', """
            $: << '.'
            require 'thing'

            describe 'Thing#to_hash' do
              specify { Thing.new.to_hash.should === {} }
            end
          """
          mutate 'Thing#to_hash spec/thing_spec.rb'
        end

        specify 'there are no possible mutations' do
          all_output.should include('no possible mutations')
        end
      end
    end

    context 'that contains {:foo => {:bar => 3}}' do
      before do
        write_file 'thing.rb', """
          class Thing
            def to_hash
              {:foo => {:bar => 3}}
            end
          end
        """
      end

      context 'with an expectation that hash[:foo][:bar] is 3' do
        before do
          write_file 'spec/thing_spec.rb', """
            $: << '.'
            require 'thing'

            describe 'Thing#to_hash' do
              specify { Thing.new.to_hash[:foo][:bar].should eq(3) }
            end
          """
          mutate 'Thing#to_hash spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that hash[:foo][:bar] is a Fixnum' do
        before do
          write_file 'spec/thing_spec.rb', """
            $: << '.'
            require 'thing'

            describe 'Thing#to_hash' do
              specify { Thing.new.to_hash[:foo][:bar].should be_kind_of(Fixnum) }
            end
          """
          mutate 'Thing#to_hash spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
