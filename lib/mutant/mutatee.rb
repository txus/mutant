require 'forwardable'

module Mutant
  class Mutatee
    extend Forwardable

    attr_reader :implementation, :mutations

    def initialize(implementation)
      @implementation = implementation
      @mutations = []
    end

    def_delegators :@implementation, :class_name, :method_name, :to_s

    def clean
      body.array.delete_if do |literal|
        not Mutant::Literal.constants.include?(literal.class.basename)
      end
    end

    def set_mutations
      nodes.each do |node|
        @mutations << Mutation.new(node, body.array)
      end
    end

    def nodes
      body.array.map {|item| Node.new(item) }
    end

    def mutations_remaining
      @mutations.reject(&:mutated?)
    end

    def ast
      @ast ||= rbx_method.parse_file && marshal(rbx_method.ast)
    end

    def body
      @body ||= rbx_method.is_a?(SingletonMethod) ? ast.body.body : ast.body
    end

    def rbx_method
      @rbx_method ||=
        case implementation.scope_type
        when :singleton then SingletonMethod.new \
          implementation.constant.method(method_name)
        when :instance then InstanceMethod.new \
          implementation.constant.instance_method(method_name)
        end
    end

    private

    def marshal(data)
      Marshal.load(Marshal.dump(data))
    end
  end
end
