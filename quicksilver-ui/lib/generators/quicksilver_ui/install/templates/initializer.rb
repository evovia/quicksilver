# Look for Phlex components in the views folder
Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views")
)

# Add a folder specifically for UI components, that are generalized and
# reusable, like modals and accordions.
Rails.autoloaders.main.push_dir(
  Rails.root.join("app/views/ui"), namespace: UI
)
