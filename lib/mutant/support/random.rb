module Mutant
	class Random
		ALLOWED_CHARACTERS = Array('a'..'z') + Array('A'..'Z') + Array('0'..'9')
		DEFAULT_LENGTH = 50

		def self.symbol
			Array.new(DEFAULT_LENGTH) { ALLOWED_CHARACTERS.choice }.join.to_sym
		end
	end
end