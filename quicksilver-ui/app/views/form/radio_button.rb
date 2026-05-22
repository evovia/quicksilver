# frozen_string_literal: true

class Form::RadioButton < Form::BaseTag
  ALLOWED_OPTIONS = [:checked, :tag_value].freeze

  class << self
    def allowed_options
      super + ALLOWED_OPTIONS
    end
  end

  prop :tag_value, _Any, reader: :private

  def view_template
    input(type: :radio, class: classes, data:, **options_with_defaults)
  end

  private

  def default_classes
    "ui-form-radio"
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
end
