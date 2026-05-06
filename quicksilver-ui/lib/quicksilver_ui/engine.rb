# frozen_string_literal: true

module QuicksilverUI
  class Engine < ::Rails::Engine
    isolate_namespace QuicksilverUI

    config.autoload_paths << root.join("app", "helpers").to_s
  end
end
