require 'mutant'
require 'aruba/api'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.include Aruba::Api, :example_group => {
    :file_path => /spec\/functional/
  }
end
