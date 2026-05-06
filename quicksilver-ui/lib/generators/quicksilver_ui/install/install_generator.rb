# frozen_string_literal: true

require "rails/generators"

module QuicksilverUI
  module Generators
    class InstallGenerator < Rails::Generators::Base
      namespace "quicksilver_ui:install"

      source_root File.expand_path("templates", __dir__)

      def add_gems
        %w[phlex-rails literal tailwind_merge].each do |gem_name|
          unless gem_installed?(gem_name)
            say "Adding #{gem_name} to Gemfile...", :yellow
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
