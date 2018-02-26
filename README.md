# CliMarkdown

Library generates markdown from a Thor CLI class.  The markdown is meant to be served as part of a Jekyll static website.

## Usage

To use, add the following to your `Rakefile`:

```ruby
require_relative "lib/your_tool"
require "cli_markdown"
desc "Generates cli reference docs as markdown"
task :docs do
  index_summary = "Summary of tool"
  CliMarkdown::Creator.create_all(cli_class: YourTool::CLI, cli_name: "your_tool", index_summary: index_summary)
end
```

* The `YourTool::CLI` class must be a Thor class.
* The cli_name is the name of the cli command used for your tool.

To generate docs, you can call:

    rake docs

This will generate docs in the `docs/_reference` folder.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cli_markdown'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cli_markdown.
