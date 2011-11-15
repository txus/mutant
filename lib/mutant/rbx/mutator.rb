module Mutant
  module Rbx
    class Mutator
      def initialize(match)
        @match = match
      end

      def mutate
        @match.method.parse_file

        ast = Marshal.load(Marshal.dump(@match.method.ast))
        ast.body.body.array = [ swap(ast.body.body.array[0]) ]

        # wrap the method in an AST for the class
        class_ast = Rubinius::AST::Class.new(
          1, @match.method_class, nil, Rubinius::AST::Block.new(1, [ ast ])
        )

        # create a script to contain the class AST
        root = Rubinius::AST::Script.new(class_ast)
        root.file = @match.method.source_file

        # setup the compiler
        compiler = Rubinius::Compiler.new(:bytecode, :compiled_method)
        compiler.generator.input(root)

        # compile the script and replace the original method
        # with the mutated method
        cm     = compiler.run
        script = cm.create_script
        Rubinius.run_script script.compiled_method
      end

      def swap(literal)
        case literal
        when Rubinius::AST::TrueLiteral
          Rubinius::AST::FalseLiteral.new(1)
        when Rubinius::AST::FalseLiteral
          Rubinius::AST::TrueLiteral.new(1)
        end
      end
    end
  end
end
