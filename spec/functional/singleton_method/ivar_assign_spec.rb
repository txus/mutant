require 'spec_helper'

describe 'Mutating instance variable assignments' do
  context 'for an instance method' do
    context 'that contains @a = 1' do
      before do
        write_file 'thing.rb', """
          class Thing
            class << self; attr_reader :a; end
            def self.set_a
              @a = 1
            end
          end
        """
      end

      context 'with an expectation that a will be set to 1' do
        before do
          write_file 'spec/thing_spec.rb', """
            $: << '.'
            require 'thing'

            describe 'Thing.set_a' do
              specify do
                Thing.set_a
                Thing.a.should eq(1)
              end
            end
          """
          mutate 'Thing.set_a spec/thing_spec.rb'
        end

        specify 'the mutation passes' do
          all_output.should include('passed')
        end
      end

      context 'with an expectation that a will bet set to some number' do
        before do
          write_file 'spec/thing_spec.rb', """
            $: << '.'
            require 'thing'

            describe 'Thing.set_a' do
              specify do
                Thing.set_a
                Thing.a.should be_kind_of(Fixnum)
              end
            end
          """
          mutate 'Thing.set_a spec/thing_spec.rb'
        end

        specify 'the mutation fails' do
          all_output.should include('failed')
        end
      end
    end
  end
end
