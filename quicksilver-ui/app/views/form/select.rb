# frozen_string_literal: true

class Form::Select < Form::BaseTag
  prop :choices, Array, reader: :private
  prop :selected, _Any?, predicate: :private, reader: :private
  prop :include_blank, _Union(_Boolean, String), default: true, predicate: :private, reader: :private
  prop :prompt, _String?, reader: :private
  prop :disabled, _Any?, reader: :private
  prop :include_hidden, _Boolean, default: true, predicate: :private, reader: :private
  prop :html_options, Hash, default: {}.freeze, reader: :private

  def view_template
    input(type: :hidden, name:, value: "", autocomplete: "off") if include_hidden?
    select(id:, name:, class: classes, **html_options) do
      if prompt
        option(value: "") { prompt }
      elsif include_blank?
        blank_text = include_blank.is_a?(String) ? include_blank : nil
        option(value: "") { blank_text }
      end
      choices.each do |choice|
        option(value: value_for(choice), selected: selected_for?(choice), disabled: disabled_for?(choice)) { text_for(choice) }
      end
    end
  end

  private

  def default_classes = "ui-form-select"

  def value_for(choice) = choice.last

  def text_for(choice) = choice.first

  def selected_for?(choice) = value_for(choice) == selected

  def disabled_for?(choice)
    return false unless disabled

    if disabled.is_a?(Array)
      disabled.include?(value_for(choice))
    else
      value_for(choice) == disabled
    end
  end
end
