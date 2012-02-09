require 'spec_helper'

describe Mutant::Mutatee do
  describe '#rbx_method' do
    setup_thing do
      def self.bar; end
      def bar; end
    end

    context 'given an implementation for a singleton method' do
      let(:implementation) { Mutant::Implementation.new('Thing.bar') }
      let(:mutatee) { Mutant::Mutatee.new(implementation) }

      it 'returns a SingletonMethod' do
        mutatee.rbx_method.should be_an_instance_of(Mutant::SingletonMethod)
      end
    end

    context 'given an implementation for an instance method' do
      let(:implementation) { Mutant::Implementation.new('Thing#bar') }
      let(:mutatee) { Mutant::Mutatee.new(implementation) }

      it 'returns an InstanceMethod' do
        mutatee.rbx_method.should be_an_instance_of(Mutant::InstanceMethod)
      end
    end
  end
end