module Mutant
  module Rbx
    class Mutator
      def initialize(mutatee)
        @mutatee = mutatee
      end

      def mutate
        @mutatee.rbx_method.parse_file

        @ast = Marshal.load(Marshal.dump(@mutatee.rbx_method.ast))
        body = @mutatee.rbx_method.is_a?(SingletonMethod) ? @ast.body.body : @ast.body
        body.array = [ swap(body.array[0]) ]

        block = Rubinius::AST::Block.new(1, [ @ast ])

        # wrap the method in an AST for the class
        class_ast = Rubinius::AST::Class.new(
          1, @mutatee.class_name.to_sym, nil, block
        )

        # create a script to contain the class AST
        root = Rubinius::AST::Script.new(class_ast)
        root.file = @mutatee.rbx_method.source_file

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
        when Rubinius::AST::SymbolLiteral
          Rubinius::AST::SymbolLiteral.new(1, Random.symbol)
        when Rubinius::AST::StringLiteral
          Rubinius::AST::StringLiteral.new(1, Random.string)
        end
      end
    end
  end
end
