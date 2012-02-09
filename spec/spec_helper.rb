require 'mutant'
require 'aruba/api'

Dir['./spec/support/*.rb'].map {|f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.extend ExampleGroupHelpers

  {:example_group => {:file_path => /spec\/functional/}}.tap do |options|
    config.include Aruba::Api, options
    config.before(:suite, options) { @aruba_timeout_seconds = 5 }
    config.after(:each, options) { FileUtils.remove_dir('tmp/aruba') }
  end
end
