# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    class FormGenerator < Rails::Generators::Base
      namespace "quicksilver_ui:form"

      source_root QuicksilverUI.form_path.to_s

      def self.banner
        "rails generate quicksilver_ui:form NAME [options]"
      end

      desc <<~DESC
        Generate a QuicksilverUI form component into your application.

        Available form components:
      DESC

      def self.desc(description = nil)
        return super if description

        components = Dir.glob(File.join(QuicksilverUI.form_path, "*.rb"))
          .map { |f| File.basename(f, ".rb") }
          .reject { |n| n == "base_tag" }
          .sort
          .map { |c| "  #{c}" }
          .join("\n")

        "#{super}\n#{components}"
      end

      argument :form_component_name, type: :string, required: true
      class_option :force, type: :boolean, default: false

      def generate_form_component
        if form_component_not_found?
          say "Form component not found: #{form_component_name}", :red
          say ""
          say "Available form components:", :green
          available_form_components.each { |c| say "  - #{c}" }
          exit 1
        end

        say "Generating #{form_component_name} form component..."
      end

      def add_gems
        all_gems.each do |gem_name|
          unless gem_installed?(gem_name)
            say "Adding #{gem_name} to Gemfile...", :yellow
            run "bundle add #{gem_name}"
          end
        end
      end

      def copy_form_component_files
        all_form_components.each do |name|
          source = File.join(self.class.source_root, "#{name}.rb")
          next unless File.exist?(source)

          copy_file source, Rails.root.join("app/views/form", "#{name}.rb"), force: options["force"]
        end
      end

      def copy_stylesheets
        all_stylesheets.each do |name|
          source = File.join(QuicksilverUI.stylesheets_path, "#{name}.css")
          next unless File.exist?(source)

          dest = Rails.root.join("app/assets/tailwind", "#{name}.css")
          copy_file source, dest, force: options["force"]
          add_css_import(name)
        end
      end

      def copy_form_builder
        source = File.join(templates_path, "app_form_builder.rb")
        dest = Rails.root.join("app/helpers/app_form_builder.rb")
        copy_file source, dest, force: options["force"]
      end

      def copy_form_helper
        source = File.join(templates_path, "app_form_helper.rb")
        dest = Rails.root.join("app/helpers/app_form_helper.rb")
        copy_file source, dest, force: options["force"]
      end

      def done
        say ""
        say "#{form_component_name} form component generated!", :green

        deps = all_form_components - [file_name]
        if deps.any?
          say "  Dependencies copied: #{deps.join(", ")}", :cyan
        end
      end

      private

      def all_form_components
        @all_form_components ||= QuicksilverUI.resolve_form_dependencies(file_name)
      end

      def all_stylesheets
        all_form_components.flat_map { |name| QuicksilverUI::FORM_DEPENDENCIES.dig(name, :stylesheets) || [] }.uniq
      end

      def all_gems
        all_form_components.flat_map { |name| QuicksilverUI::FORM_DEPENDENCIES.dig(name, :gems) || [] }.uniq
      end

      def gem_installed?(name)
        Gem::Specification.find_all_by_name(name).any?
      end

      def add_css_import(name)
        app_css = Rails.root.join("app/assets/tailwind/application.css")
        import_line = "@import \"./#{name}.css\" layer(affordances);"

        if File.exist?(app_css)
          content = File.read(app_css)
          return if content.include?(import_line)

          lines = content.lines
          last_import_index = lines.rindex { |l| l.start_with?("@import") }

          if last_import_index
            lines.insert(last_import_index + 1, "#{import_line}\n")
          else
            lines.unshift("#{import_line}\n")
          end

          File.write(app_css, lines.join)
        else
          create_file app_css, "#{import_line}\n"
        end

        say "  Added import for #{name}.css to application.css", :green
      end

      def form_component_not_found?
        !File.exist?(File.join(self.class.source_root, "#{file_name}.rb"))
      end

      def templates_path
        File.join(File.dirname(__FILE__), "templates")
      end

      def file_name
        form_component_name.underscore
      end

      def available_form_components
        Dir.glob(File.join(self.class.source_root, "*.rb"))
          .map { |f| File.basename(f, ".rb") }
          .reject { |name| name == "base_tag" }
          .sort
      end
    end
  end
end
