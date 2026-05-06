# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    class ComponentGenerator < Rails::Generators::Base
      namespace "quicksilver_ui:component"

      source_root QuicksilverUI.ui_path.to_s

      argument :component_name, type: :string, required: true
      class_option :force, type: :boolean, default: false

      def generate_component
        if component_not_found?
          say "Component not found: #{component_name}", :red
          say ""
          say "Available components:", :green
          available_components.each { |c| say "  - #{c}" }
          exit 1
        end

        say "Generating #{component_name} component..."
      end

      def copy_component_files
        component_file_paths.each do |file_path|
          relative = Pathname.new(file_path).relative_path_from(self.class.source_root)
          copy_file file_path, Rails.root.join("app/views/ui", relative), force: options["force"]
        end
      end

      def done
        say ""
        say "#{component_name} component generated!", :green
      end

      private

      def component_not_found?
        !File.exist?(component_file_path) && !Dir.exist?(component_folder_path)
      end

      def component_folder_name
        component_name.underscore
      end

      # Single-file component (e.g., alert.rb)
      def component_file_path
        File.join(self.class.source_root, "#{component_folder_name}.rb")
      end

      # Multi-file component folder (e.g., dropdown/)
      def component_folder_path
        File.join(self.class.source_root, component_folder_name)
      end

      def component_file_paths
        paths = []

        # Main component file
        if File.exist?(component_file_path)
          paths << component_file_path
        end

        # Nested files in component folder
        if Dir.exist?(component_folder_path)
          paths.concat Dir.glob(File.join(component_folder_path, "**/*.rb"))
        end

        paths
      end

      def available_components
        Dir.glob(File.join(self.class.source_root, "*.rb"))
          .map { |f| File.basename(f, ".rb") }
          .reject { |name| name == "base" }
          .sort
      end
    end
  end
end
