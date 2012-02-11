require 'spec_helper'

describe Mutant::Literal do
  describe '.literal_class' do
    context 'given an instance of Rubinius::AST::TrueLiteral' do
      let(:true_literal) { Rubinius::AST::TrueLiteral.new(1) }

      it 'returns the Mutant::Rbx::Literal::TrueLiteral class' do
        Mutant::Literal.literal_class(true_literal).should eq(
          Mutant::Literal::TrueLiteral
        )
      end
    end
  end

  describe '#swap' do
    context 'initialized with an instance of Rubinius::AST::TrueLiteral' do
      let(:true_literal) { Rubinius::AST::TrueLiteral.new(1) }

      it 'calls Mutant::Rbx::Literal::TrueLiteral#swap' do
        Mutant::Literal::TrueLiteral.should_receive(:new).with(true_literal) {
          double(Mutant::Literal::TrueLiteral, :swap => true)
        }
        Mutant::Literal.new(true_literal).swap
      end
    end
  end

  describe Mutant::Literal::FalseLiteral do
    describe '#swap' do
      let(:node) { double('node', :line => 1) }

      it 'returns an instance of Rubinius::AST::TrueLiteral' do
        Mutant::Literal::FalseLiteral.new(node).swap.should be_an_instance_of(
          Rubinius::AST::TrueLiteral
        )
      end
    end
  end

  describe Mutant::Literal::TrueLiteral do
    describe '#swap' do
      let(:node) { double('node', :line => 1) }

      it 'returns an instance of Rubinius::AST::FalseLiteral' do
        Mutant::Literal::TrueLiteral.new(node).swap.should be_an_instance_of(
          Rubinius::AST::FalseLiteral
        )
      end
    end
  end

  describe Mutant::Literal::SymbolLiteral do
    describe '#swap' do
      let(:node) { double('node') }

      it "sets the node's value to a random symbol" do
        node.should_receive(:value=).with(instance_of(Symbol))
        Mutant::Literal::SymbolLiteral.new(node).swap.should eq(node)
      end
    end
  end

  describe Mutant::Literal::StringLiteral do
    describe '#swap' do
      let(:node) { double('node') }

      it "sets the node's string to a random string" do
        node.should_receive(:string=).with(instance_of(String))
        Mutant::Literal::StringLiteral.new(node).swap.should eq(node)
      end
    end
  end

  describe Mutant::Literal::FixnumLiteral do
    describe '#swap' do
      let(:node) { double('node') }

      it "sets the node's value to a random fixnum" do
        node.should_receive(:value=).with(instance_of(Fixnum))
        Mutant::Literal::FixnumLiteral.new(node).swap.should eq(node)
      end
    end
  end

  describe Mutant::Literal::FloatLiteral do
    describe '#swap' do
      let(:node) { double('node') }

      it "sets the node's value to a random float" do
        node.should_receive(:value=).with(instance_of(Float))
        Mutant::Literal::FloatLiteral.new(node).swap.should eq(node)
      end
    end
  end

  describe Mutant::Literal::Range do
    describe '#swap' do
      let(:node) { double('node', :line => 1) }

      it "sets the node's start and finish to an instance of Rubinius::AST::FixnumLiteral" do
        node.should_receive(:start=).with(
          instance_of(Rubinius::AST::FixnumLiteral)
        )
        node.should_receive(:finish=).with(
          instance_of(Rubinius::AST::FixnumLiteral)
        )
        Mutant::Literal::Range.new(node).swap.should eq(node)
      end
    end
  end

  describe Mutant::Literal::LocalVariableAssignment do
    describe '#swap' do
      context "with the node's value set to an instance of Rubinius::AST::TrueLiteral" do
        let(:node) do
          double('node', :value => Rubinius::AST::TrueLiteral.new(1))
        end

        it "sets the node's value to an instance of Rubinius::AST::FalseLiteral" do
          node.should_receive(:value=).with(
            instance_of(Rubinius::AST::FalseLiteral)
          )
          Mutant::Literal::LocalVariableAssignment.new(node).swap.should eq(node)
        end
      end
    end
  end
end
