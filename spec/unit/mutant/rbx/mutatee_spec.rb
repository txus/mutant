require 'spec_helper'

module Mutant
	module Rbx
		describe Mutatee do
			describe '#rbx_method' do
				before do
					class ::Foo
						def self.bar; end
						def bar; end
					end
				end

				context 'given an Implementation for a singleton method' do
					let(:implementation) { Implementation.new('Foo.bar') }
					let(:mutatee) { Mutatee.new(implementation) }

					it 'returns a SingletonMethod' do
						mutatee.rbx_method.should be_an_instance_of(SingletonMethod)
					end
				end

				context 'given an Implementation for an instance method' do
					let(:implementation) { Implementation.new('Foo#bar') }
					let(:mutatee) { Mutatee.new(implementation) }

					it 'returns an InstanceMethod' do
						mutatee.rbx_method.should be_an_instance_of(InstanceMethod)
					end
				end
			end
		end
	end
end