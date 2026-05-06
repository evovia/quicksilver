# frozen_string_literal: true

module QuicksilverUI
  class Engine < ::Rails::Engine
    isolate_namespace QuicksilverUI

    config.autoload_paths << root.join("app", "helpers").to_s

    initializer "quicksilver_ui.assets" do |app|
      app.config.assets.paths << QuicksilverUI.stylesheets_path.to_s
      app.config.assets.paths << root.join("app/javascript").to_s
    end

    initializer "quicksilver_ui.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
    end
  end
end
