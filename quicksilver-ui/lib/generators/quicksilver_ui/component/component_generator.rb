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
        all_components.each do |name|
          paths = file_paths_for(name)
          paths.each do |file_path|
            relative = Pathname.new(file_path).relative_path_from(self.class.source_root)
            copy_file file_path, Rails.root.join("app/views/ui", relative), force: options["force"]
          end
        end
      end

      def copy_stylesheets
        all_stylesheets.each do |name|
          source = File.join(QuicksilverUI.stylesheets_path, "#{name}.css")
          next unless File.exist?(source)

          copy_file source, Rails.root.join("app/assets/tailwind", "#{name}.css"), force: options["force"]
        end
      end

      def copy_controllers
        all_controllers.each do |name|
          source = File.join(QuicksilverUI.javascript_controllers_path, "#{name}_controller.js")
          next unless File.exist?(source)

          copy_file source, Rails.root.join("app/javascript/controllers", "#{name}_controller.js"), force: options["force"]
        end
      end

      def copy_mixins
        all_mixins.each do |name|
          source = File.join(QuicksilverUI.javascript_mixins_path, "#{name}.js")
          next unless File.exist?(source)

          copy_file source, Rails.root.join("app/javascript/mixins", "#{name}.js"), force: options["force"]
        end
      end

      def done
        say ""
        say "#{component_name} component generated!", :green

        deps = all_components - [component_folder_name]
        if deps.any?
          say "  Dependencies copied: #{deps.join(", ")}", :cyan
        end
      end

      private

      def all_components
        @all_components ||= QuicksilverUI.resolve_dependencies(component_folder_name)
      end

      def all_stylesheets
        all_components.flat_map { |name| QuicksilverUI::DEPENDENCIES.dig(name, :stylesheets) || [] }.uniq
      end

      def all_controllers
        all_components.flat_map { |name| QuicksilverUI::DEPENDENCIES.dig(name, :controllers) || [] }.uniq
      end

      def all_mixins
        all_components.flat_map { |name| QuicksilverUI::DEPENDENCIES.dig(name, :mixins) || [] }.uniq
      end

      def component_not_found?
        !File.exist?(component_file_path) && !Dir.exist?(component_folder_path)
      end

      def component_folder_name
        component_name.underscore
      end

      def component_file_path
        File.join(self.class.source_root, "#{component_folder_name}.rb")
      end

      def component_folder_path
        File.join(self.class.source_root, component_folder_name)
      end

      def file_paths_for(name)
        paths = []
        file = File.join(self.class.source_root, "#{name}.rb")
        folder = File.join(self.class.source_root, name)

        paths << file if File.exist?(file)
        paths.concat Dir.glob(File.join(folder, "**/*.rb")) if Dir.exist?(folder)
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
