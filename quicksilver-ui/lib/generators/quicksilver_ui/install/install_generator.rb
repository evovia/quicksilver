# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    class InstallGenerator < Rails::Generators::Base
      namespace "quicksilver_ui:install"

      source_root File.expand_path("templates", __dir__)

      def check_dependencies
        %w[phlex-rails literal tailwind_merge rails_icons].each do |gem_name|
          unless gem_installed?(gem_name)
            say "Missing dependency: #{gem_name}. Adding to Gemfile.", :yellow
            run "bundle add #{gem_name}"
          end
        end
      end

      def create_initializer
        template "initializer.rb", Rails.root.join("config/initializers/quicksilver_ui.rb")
      end

      def create_base_component
        template "base.rb", Rails.root.join("app/views/ui/base.rb")
      end

      def copy_stylesheets
        say "Copying Tailwind component stylesheets"

        Dir.glob(File.join(QuicksilverUI.stylesheets_path, "*.css")).each do |file|
          copy_file file, Rails.root.join("app/assets/tailwind", File.basename(file))
        end
      end

      def copy_javascript
        say "Copying Stimulus controllers"

        Dir.glob(File.join(QuicksilverUI.javascript_controllers_path, "*.js")).each do |file|
          copy_file file, Rails.root.join("app/javascript/controllers", File.basename(file))
        end

        Dir.glob(File.join(QuicksilverUI.javascript_mixins_path, "*.js")).each do |file|
          copy_file file, Rails.root.join("app/javascript/mixins", File.basename(file))
        end
      end

      def done
        say ""
        say "Quicksilver UI installed successfully!", :green
        say "Run `bin/rails g quicksilver_ui:component Alert` to generate a component.", :green
      end

      private

      def gem_installed?(name)
        Gem::Specification.find_all_by_name(name).any?
      end
    end
  end
end
