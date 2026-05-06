# frozen_string_literal: true

# UI module is defined by the quicksilver_ui gem engine on require.
# We define Previews here for the docs-specific preview components.
module Previews
end

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views")
)

# app/views/ui/ is still autoloaded for docs-only components like Preview.
Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views/ui"), namespace: UI
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views/previews"), namespace: Previews
)
