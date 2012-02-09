module ClassExtensions
  def basename
    name.split('::').last
  end
end

Class.send :include, ClassExtensions
Rubinius::AST::Node.send :include, ClassExtensions