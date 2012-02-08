module Mutant
  class Random
    ALLOWED_SYMBOL_CHARACTERS = Array('a'..'z') + Array('A'..'Z')

    def self.string
      ENV['RANDOM_STRING'] or
      Array.new(rand(50)) { rand(126).chr }.join
    end

    def self.symbol
      ( ENV['RANDOM_SYMBOL'] or
        Array.new(rand(50).next) { ALLOWED_SYMBOL_CHARACTERS.choice }.join
      ).to_sym
    end

    def self.range
      if ENV['RANDOM_RANGE_MIN'] and ENV['RANDOM_RANGE_MAX']
        min, max = ENV['RANDOM_RANGE_MIN'].to_i, ENV['RANDOM_RANGE_MAX'].to_i
      else
        min, max = rand(50)
        max = min + rand(50)
      end

      Range.new(min, max)
    end
  end
end