require 'spec_helper'

module Mutant
	describe Random do
		describe '.symbol' do
			it 'returns a random symbol' do
				Random.symbol.should be_a(Symbol)
			end
		end
	end
end