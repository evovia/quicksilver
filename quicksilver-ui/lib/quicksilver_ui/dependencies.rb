# frozen_string_literal: true

module QuicksilverUI
  DEPENDENCIES = {
    "accordion" => {
      components: %w[icon],
      stylesheets: [],
      controllers: [],
      mixins: [],
      gems: []
    },
    "alert" => {
      components: %w[icon],
      stylesheets: %w[alert],
      controllers: %w[dismissable],
      mixins: [],
      gems: []
    },
    "avatar" => {
      components: [],
      stylesheets: [],
      controllers: [],
      mixins: [],
      gems: []
    },
    "badge" => {
      components: %w[icon],
      stylesheets: %w[badge],
      controllers: [],
      mixins: [],
      gems: []
    },
    "dropdown" => {
      components: %w[icon],
      stylesheets: [],
      controllers: %w[dropdown],
      mixins: %w[use_floating_ui],
      gems: []
    },
    "icon" => {
      components: [],
      stylesheets: [],
      controllers: [],
      mixins: [],
      gems: %w[rails_icons]
    },
    "modal" => {
      components: %w[icon],
      stylesheets: %w[modal],
      controllers: %w[modal],
      mixins: [],
      gems: []
    }
  }.freeze

  def self.resolve_dependencies(component_name)
    resolved = Set.new
    resolve(component_name, resolved)
    resolved.to_a
  end

  def self.resolve(name, resolved)
    return if resolved.include?(name)

    resolved << name
    deps = DEPENDENCIES[name]
    return unless deps

    deps[:components].each { |dep| resolve(dep, resolved) }
  end
  private_class_method :resolve
end
