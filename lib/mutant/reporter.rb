module Mutant
	class Reporter
		WIDTH = 70

		def self.mutating(mutation)
			puts "Mutating line #{mutation.line}"
			puts "  #{mutation.from} >>>#{mutation.to.nested? ? "\n  " : " "}#{mutation.to}"
			puts
		end

		def self.method_loaded(mutatee)
			info "#{mutatee} loaded with #{mutatee.mutations.size} " \
					 "possible #{pluralize(mutatee.mutations.size, 'mutation')}"
		end

		def self.no_mutations(mutatee)
			warning "#{mutatee} has no possible mutations"
		end

		def self.info(message)
			puts "*" * WIDTH
			puts "***  #{message}"
			puts "*" * WIDTH
			puts
		end

		def self.warning(message)
			puts "!" * WIDTH
			puts "!!!  #{message}"
			puts "!" * WIDTH
			puts
		end

		def self.pluralize(count, singular, plural = nil)
			count == 1 ? singular : plural || singular.insert(-1, 's')
		end
	end
end