# frozen_string_literal: true

module UI
  extend Phlex::Kit
end

module Previews
end

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views")
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views/ui"), namespace: UI
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views/previews"), namespace: Previews
)
