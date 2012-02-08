module Mutant
  class Mutator
    COMPILER = Rubinius::Compiler.new(:bytecode, :compiled_method)

    def initialize(mutatee)
      @mutatee = mutatee
    end

    def mutate
      @mutatee.clean
      @mutatee.set_mutations

      if @mutatee.mutations.size.zero?
        Reporter.no_mutations(@mutatee)
        return
      else
        Reporter.method_loaded(@mutatee)
      end

      @mutatee.mutations.each do |mutation|
        @mutatee.body.array = mutation.mutate && mutation.array
        Reporter.mutating(mutation)
        # setup the compiler
        COMPILER.generator.input(root)
        # compile the script and replace the original method
        # with the mutated method
        Rubinius.run_script(compiled_method)
      end
    end

    def block
      Rubinius::AST::Block.new(1, [ @mutatee.ast ])
    end

    def class_ast
      Rubinius::AST::Class.new(1, @mutatee.class_name.to_sym, nil, block)
    end

    def root
      Rubinius::AST::Script.new(class_ast).tap do |script|
        script.file = @mutatee.rbx_method.source_file
      end
    end

    def compiled_method
      COMPILER.run.create_script.compiled_method
    end
  end
end
