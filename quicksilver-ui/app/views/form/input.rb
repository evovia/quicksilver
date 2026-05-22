# frozen_string_literal: true

class Form::Input < Form::BaseTag
  def view_template
    input(type:, class: classes, **options_with_defaults)
  end

  private

  def default_classes = "ui-form-control"
end
