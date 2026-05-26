# frozen_string_literal: true

require_relative "lib/quicksilver_ui/version"

Gem::Specification.new do |spec|
  spec.name = "quicksilver_ui"
  spec.version = QuicksilverUI::VERSION
  spec.authors = ["Evovia"]
  spec.summary = "Quicksilver UI component library for Rails"
  spec.description = "A collection of Phlex-based UI components with Rails generators for easy installation."
  spec.homepage = "https://evovia.com"
  spec.metadata = {"source_code_uri" => "https://github.com/evovia/quicksilver"}
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.files = Dir[
    "lib/**/*",
    "app/**/*",
    "README.md"
  ]

  spec.require_paths = ["lib"]
end
