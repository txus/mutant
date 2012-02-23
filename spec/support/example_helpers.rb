module ExampleHelpers
  def mutate(cmd, fail_on_error = true)
    run_simple "../../exe/mutate #{cmd}", fail_on_error
  end
end
