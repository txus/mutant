require 'spec_helper'

describe 'Mutating hashes' do
  context 'for a singleton method' do
    context 'that contains {:foo => {:bar => 3}}' do
      before do
        write_file 'thing.rb', """
          class Thing
            def self.to_hash
              {:foo => {:bar => 3}}
            end
          end
        """
      end

      context 'with an expectation that hash[:foo][:bar] is 3' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.to_hash' do
              specify { Thing.to_hash[:foo][:bar].should eq(3) }
            end
          """
          mutate 'Thing.to_hash spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that hash[:foo][:bar] is a Fixnum' do
        before do
          write_file 'spec/thing_spec.rb', """
            require 'thing'

            describe 'Thing.to_hash' do
              specify { Thing.to_hash[:foo][:bar].should be_kind_of(Fixnum) }
            end
          """
          mutate 'Thing.to_hash spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
