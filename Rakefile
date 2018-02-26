require "bundler/gem_tasks"
task :default => :spec

# In a real project the require will be the project itself.
# This ask is only here to pass specs.
require "lono"
require "./lib/cli_markdown"
desc "Generates cli reference docs as markdown"
task :docs do
  CliMarkdown::Creator.create_all(Lono::CLI)
end
