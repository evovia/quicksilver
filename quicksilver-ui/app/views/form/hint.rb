# frozen_string_literal: true

class Form::Hint < Form::BaseTag
  prop :text, _Nilable(String), reader: :private

  def view_template
    p(class: classes) { text || method }
  end

  private

  def default_classes
    "ui-form-hint"
  end
end
