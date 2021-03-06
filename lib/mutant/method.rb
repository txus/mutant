module Mutant
  class Method < Rubinius::Melbourne
    attr_reader :ast, :source_name, :source_file, :source_line

    DEFAULT_LINE = 1

    def initialize(method)
      @ast         = nil
      @source_name = method.name.to_sym
      @source_file, @source_line = method.source_location
      super(source_file, DEFAULT_LINE)
    end

    # TODO: Check for edge cases where just the line won't work.
    def match?(ast)
      source_line == ast.line
    end
  end

  class InstanceMethod < Method
    def process_defn(*)
      super.tap { |ast| @ast = ast if match?(ast) }
    end
  end

  class SingletonMethod < Method
    def process_defs(*)
      super.tap { |ast| @ast = ast if match?(ast.body) }
    end
  end
end
