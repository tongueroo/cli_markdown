module CliMarkdown
  class Index
    def initialize(cli_class, cli_name)
      @cli_class = cli_class
      @cli_name = cli_name
    end

    def path
      "docs/reference.md"
    end

    def command_list
      @cli_class.commands.keys.sort.map.each do |command_name|
        page = Page.new(
            cli_class: @cli_class,
            cli_name: @cli_name,
            command_name: command_name,
          )
        link = page.path.sub("docs/", "")
        # Example: [lono cfn]({% link _reference/lono-cfn.md %})
        "* [#{@cli_name} #{command_name}]({% link #{link} %})"
      end.join("\n")
    end

    def doc
      <<-EOL
---
title: CLI Reference
---
{% include reference.md %}

#{command_list}
EOL
    end
  end
end
