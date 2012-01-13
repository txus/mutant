module Mutant
	class Reporter
		WIDTH = 70

		def self.method_loaded(method, mutations_count)
			info "#{method} loaded with #{mutations_count} " \
					 "possible #{pluralize(mutations_count, 'mutation')}"
		end

		def self.no_mutations(method)
			warning "#{method} has no possible mutations"
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