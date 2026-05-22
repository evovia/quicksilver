# frozen_string_literal: true

class Form::Error < Form::BaseTag
  prop :text, _Nilable(String), reader: :private

  def view_template
    p(class: classes) { text }
  end

  private

  def default_classes
    "ui-form-error"
  end
end
