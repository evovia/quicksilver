# frozen_string_literal: true

class Form::Label < Form::BaseTag
  prop :text, _Nilable(String), reader: :private

  def view_template
    label(class: classes, **options_with_defaults) { text || method }
  end

  private

  def default_classes
    "ui-form-label"
  end

  def default_options
    {for: id}
  end
end
