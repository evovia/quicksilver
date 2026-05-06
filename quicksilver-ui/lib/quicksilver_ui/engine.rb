# frozen_string_literal: true

require "phlex"

# Define the UI module at require time so it's available to host app initializers.
module UI
  extend Phlex::Kit
end

module QuicksilverUI
  class Engine < ::Rails::Engine
    isolate_namespace QuicksilverUI

    initializer "quicksilver_ui.autoloading" do |app|
      app.autoloaders.main.push_dir(
        QuicksilverUI.ui_path, namespace: UI
      )
    end
  end
end
