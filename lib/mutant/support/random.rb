module Mutant
	class Random
		ALLOWED_SYMBOL_CHARACTERS = Array('a'..'z') + Array('A'..'Z')

		def self.string
    	Array.new(rand(50)) { rand(126).chr }.join
		end

		def self.symbol
			Array.new(rand(50).next) { ALLOWED_SYMBOL_CHARACTERS.choice }.join.to_sym
		end
	end
end