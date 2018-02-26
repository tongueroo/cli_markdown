require "./lib/cli_markdown"

module Helper
  def execute(cmd)
    puts "Running: #{cmd}" if show_command?
    out = `#{cmd}`
    puts out if show_command?
    out
  end

  # Added SHOW_COMMAND because DEBUG is also used by other libraries like
  # bundler and it shows its internal debugging logging also.
  def show_command?
    ENV['DEBUG'] || ENV['SHOW_COMMAND']
  end

  def clean_docs
    FileUtils.rm_rf("docs")
  end
end

RSpec.configure do |config|
  config.include Helper
  config.before(:all) do
    clean_docs
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
