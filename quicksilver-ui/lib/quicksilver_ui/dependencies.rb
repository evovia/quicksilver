# frozen_string_literal: true

module QuicksilverUI
  DEPENDENCIES = {
    "accordion" => {
      components: %w[icon],
      stylesheets: [],
      controllers: [],
      mixins: []
    },
    "alert" => {
      components: %w[icon],
      stylesheets: %w[alert],
      controllers: %w[dismissable],
      mixins: []
    },
    "avatar" => {
      components: [],
      stylesheets: [],
      controllers: [],
      mixins: []
    },
    "badge" => {
      components: %w[icon],
      stylesheets: %w[badge],
      controllers: [],
      mixins: []
    },
    "dropdown" => {
      components: %w[icon],
      stylesheets: [],
      controllers: %w[dropdown],
      mixins: %w[use_floating_ui]
    },
    "icon" => {
      components: [],
      stylesheets: [],
      controllers: [],
      mixins: []
    },
    "modal" => {
      components: %w[icon],
      stylesheets: %w[modal],
      controllers: %w[modal],
      mixins: []
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
