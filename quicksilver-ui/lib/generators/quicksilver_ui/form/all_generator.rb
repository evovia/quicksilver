# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    module Form
      class AllGenerator < Rails::Generators::Base
        namespace "quicksilver_ui:form:all"

        class_option :force, type: :boolean, default: false

        def generate_all_form_components
          say "Generating all form components..."

          available_form_components.each do |component|
            run "bin/rails generate quicksilver_ui:form #{component}#{" --force" if options["force"]}"
          end
        end

        private

        def available_form_components
          Dir.glob(File.join(QuicksilverUI.form_path, "*.rb"))
            .map { |f| File.basename(f, ".rb") }
            .reject { |name| name == "base_tag" }
            .sort
        end
      end
    end
  end
end
