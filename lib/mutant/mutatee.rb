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
        not Mutant::Literal.constants.map(&:to_sym).include?(literal.class.basename.to_sym)
      end
    end

    def set_mutations
      nodes.each do |node|
        mutation = Mutation.new(node, body.array)
        @mutations << mutation if mutation.mutatable?
      end
    end

    def nodes
      body.array.map {|item| Node.new(item) }
    end

    def mutations_remaining
      @mutations.reject(&:mutated?)
    end

    def ast
      @ast ||= rbx_method.parse_file && rbx_method.ast
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
