require 'spec_helper'

describe Mutant::Node do
  let(:item) { double('item', :line => 1) }
  let(:node) { Mutant::Node.new(item) }

  describe '#line' do
    it "returns the item's line" do
      Mutant::Node.new(item).line.should eq 1
    end
  end

  describe '#from' do
    it "returns a Formatter instance with its item set to the node's item" do
      formatter = node.from
      formatter.should be_an_instance_of(Mutant::Formatter)
      formatter.item.should eq(item)
    end
  end

  describe '#to' do
    it "returns a Formatter instance with its item set to the node's copy" do
      formatter = node.to
      formatter.should be_an_instance_of(Mutant::Formatter)
      formatter.item.should eq(node.copy)
    end
  end

  describe '#swap' do
    let(:swap) { double('swap') }
    let(:literal) { double('literal', :swap => swap) }

    before do
      Mutant::Literal.should_receive(:new).with(node.copy).and_return(literal)
    end

    it "sets the node's copy to a different Literal" do
      expect { node.swap }.to change { node.copy }.to swap
    end
  end
end