# frozen_string_literal: true

require_relative "quicksilver_ui/version"
require_relative "quicksilver_ui/engine" if defined?(Rails::Engine)

module QuicksilverUI
  class << self
    def root
      Pathname.new(File.expand_path("..", __dir__))
    end

    def ui_path
      root.join("app", "views", "ui")
    end

    def stylesheets_path
      root.join("app", "assets", "tailwind")
    end

    def javascript_controllers_path
      root.join("app", "javascript", "controllers")
    end

    def javascript_mixins_path
      root.join("app", "javascript", "mixins")
    end
  end
end
