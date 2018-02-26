require "active_support/core_ext/object"

module CliMarkdown
  class Creator
    cattr_accessor :mute

    def self.create_all(options={})
      clean unless options[:parent_command_name]
      new(options).create_all
    end

    def self.clean
      FileUtils.rm_rf("docs/_reference")
      FileUtils.rm_f("docs/reference.md")
    end

    # cli_class is top-level CLI class.
    def initialize(cli_class:, cli_name:, parent_command_name: nil)
      @cli_class = cli_class
      @cli_name = cli_name
      @parent_command_name = parent_command_name
    end

    def create_all
      create_index unless @parent_command_name

      @cli_class.commands.keys.each do |command_name|
        page = Page.new(
            cli_class: @cli_class,
            cli_name: @cli_name,
            command_name: command_name,
            parent_command_name: @parent_command_name,
          )
        create_page(page)

        if subcommand?(command_name)
          subcommand_class = subcommand_class(command_name)
          parent_command_name = command_name

          say "Creating subcommands pages for #{parent_command_name}..."
          Creator.create_all(
            cli_class: subcommand_class,
            cli_name: @cli_name,
            parent_command_name: parent_command_name
          )
        end
      end
    end

    def create_page(page)
      say "Creating #{page.path}..."
      FileUtils.mkdir_p(File.dirname(page.path))
      IO.write(page.path, page.doc)
    end

    def create_index
      page = Index.new(@cli_class, @cli_name)
      FileUtils.mkdir_p(File.dirname(page.path))
      say "Creating #{page.path}"
      IO.write(page.path, page.doc)
    end

    def subcommand?(command_name)
      @cli_class.subcommands.include?(command_name)
    end

    def subcommand_class(command_name)
      @cli_class.subcommand_classes[command_name]
    end

    def say(text)
      puts text unless self.class.mute
    end
  end
end
