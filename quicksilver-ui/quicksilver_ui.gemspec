# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "quicksilver_ui"
  spec.version = "0.1.0"
  spec.authors = ["Evovia"]
  spec.summary = "Quicksilver UI component library for Rails"
  spec.description = "A collection of Phlex-based UI components with Rails generators for easy installation."
  spec.homepage = "https://github.com/evovia/quicksilver"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.files = Dir[
    "lib/**/*",
    "app/**/*",
    "LICENSE.txt",
    "README.md"
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency "phlex-rails", "~> 2.0"
  spec.add_dependency "literal", "~> 1.0"
  spec.add_dependency "tailwind_merge", "~> 1.0"
  spec.add_dependency "rails_icons", "~> 1.0"
end
