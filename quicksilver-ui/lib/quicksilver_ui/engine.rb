# frozen_string_literal: true

module QuicksilverUI
  class Engine < ::Rails::Engine
    isolate_namespace QuicksilverUI

    config.autoload_paths << root.join("app", "helpers").to_s

    initializer "quicksilver_ui.assets" do |app|
      app.config.assets.paths << QuicksilverUI.stylesheets_path.to_s
    end
  end
end
