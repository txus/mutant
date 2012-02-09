module ExampleGroupHelpers
  def setup_thing(&block)
    before do
      Object.const_set(:Thing, Class.new(&block))
    end

    after do
      Object.send(:remove_const, :Thing) if Object.const_defined?(:Thing)
    end
  end
end