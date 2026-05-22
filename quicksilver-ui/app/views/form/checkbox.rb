# frozen_string_literal: true

class Form::Checkbox < Form::BaseTag
  ALLOWED_OPTIONS = [:multiple, :checked, :include_hidden].freeze

  class << self
    def allowed_options
      super + ALLOWED_OPTIONS
    end
  end

  prop :multiple, _Boolean?, default: false, reader: :private
  prop :include_hidden, _Union(_Boolean, String), default: true, reader: :private

  def view_template
    div do
      input(type: :hidden, name:, value: hidden_value) if include_hidden

      input(type: :checkbox, class: classes, **options_with_defaults, data:)
    end
  end

  private

  def type = :checkbox

  def name
    return "#{super}[]" if multiple?

    super
  end

  def default_classes
    "ui-form-checkbox"
  end

  def multiple?
    multiple
  end

  def default_options
    checked_value = if form.object&.respond_to?(method)
      value == form.object.public_send(method)
    else
      false
    end

    super.merge(checked: checked_value)
  end

  def value
    options[:value]
  end

  def include_hidden?
    include_hidden.present?
  end

  def hidden_value
    include_hidden || value
  end
end
