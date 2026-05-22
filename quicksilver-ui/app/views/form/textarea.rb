# frozen_string_literal: true

class Form::Textarea < Form::Input
  prop :rows, _Integer?, reader: :private
  prop :autogrow, _Boolean, default: false, predicate: :private, reader: :private

  def view_template
    textarea(class: classes, **options_with_defaults) do
      value
    end
  end

  private

  def default_classes = "ui-form-control"

  def default_options
    super.merge(rows:).tap do |opts|
      if autogrow?
        opts[:data] = (opts[:data] || {}).merge(
          controller: "autogrow",
          action: "input->autogrow#input"
        )
      end
    end
  end
end
