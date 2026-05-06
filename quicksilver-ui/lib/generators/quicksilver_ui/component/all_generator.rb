# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    module Component
      class AllGenerator < Rails::Generators::Base
        namespace "quicksilver_ui:component:all"

        class_option :force, type: :boolean, default: false

        def generate_all_components
          say "Generating all components..."

          available_components.each do |component|
            run "bin/rails generate quicksilver_ui:component #{component}#{" --force" if options["force"]}"
          end
        end

        private

        def available_components
          Dir.glob(File.join(QuicksilverUI.ui_path, "*.rb"))
            .map { |f| File.basename(f, ".rb") }
            .reject { |name| name == "base" }
            .sort
        end
      end
    end
  end
end
