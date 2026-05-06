# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    class AffordanceGenerator < Rails::Generators::Base
      namespace "quicksilver_ui:affordance"

      source_root QuicksilverUI.stylesheets_path.to_s

      argument :affordance_name, type: :string, required: true
      class_option :force, type: :boolean, default: false

      def generate_affordance
        if affordance_not_found?
          say "Affordance not found: #{affordance_name}", :red
          say ""
          say "Available affordances:", :green
          available_affordances.each { |a| say "  - #{a}" }
          exit 1
        end

        say "Generating #{affordance_name} affordance..."
      end

      def copy_stylesheet
        source = File.join(QuicksilverUI.stylesheets_path, "#{file_name}.css")
        copy_file source, Rails.root.join("app/assets/tailwind", "#{file_name}.css"), force: options["force"]
        add_css_import(file_name)
      end

      def done
        say ""
        say "#{affordance_name} affordance generated!", :green
      end

      private

      def file_name
        affordance_name.underscore
      end

      def affordance_not_found?
        !File.exist?(File.join(QuicksilverUI.stylesheets_path, "#{file_name}.css"))
      end

      def available_affordances
        Dir.glob(File.join(QuicksilverUI.stylesheets_path, "*.css"))
          .map { |f| File.basename(f, ".css") }
          .sort
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
    end
  end
end
