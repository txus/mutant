require 'spec_helper'

describe Mutant do
  describe '.run' do
    it 'runs the RSpec runner with the given arguments' do
      Mutant::Runners::RSpec.should_receive(:run).with(:foo)
      Mutant.run(:foo)
    end
  end

  describe '.mutate' do
    context 'given an implementation' do
      let(:mutatee) { double('mutatee') }
      let(:implementation) { double('implementation') }
      let(:mutator) { double('mutator') }

      before do
        mutator.should_receive(:mutate)
        implementation.should_receive(:mutatees).and_return([mutatee])
      end

      it "mutates each of the implementation's mutatees" do
        Mutant::Mutator.should_receive(:new).with(mutatee).and_return(mutator)
        Mutant.mutate(implementation)
      end
    end
  end
end
