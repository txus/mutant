module Mutant
  class Implementation
    def initialize(str)
      @str = str
    end

    def details
      @str.match(/(\w+)(\.|#)(\w+\?*)/).captures
    end

    def mutatees
      [].tap do |ary|
        if @str =~ /#|\./
          ary << Rbx::Mutatee.new(*details)
        end
      end
    end
  end
end
