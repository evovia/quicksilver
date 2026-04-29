# frozen_string_literal: true

class Form::Group < UI::Base
  prop :form, AppFormBuilder, reader: :private
  prop :method, _Union(Symbol, String), reader: :private
  prop :type, _Union(:text), reader: :private
  prop :options, Hash, :**, reader: :private

  def view_template
    div(class: classes) do
      render_field

      div(class: "space-y-0.5") do
        render Form::Hint.new(form:, method:, text: hint_text, **hint_options) if hint?
      end
    end
  end

  private

  def label_text
    options[:label]
  end

  def label_options
    options[:label_options] || {}
  end

  def label?
    label_text.present?
  end

  def input_options
    options.slice(*input_class.allowed_options)
  end

  def hint_text
    options[:hint]
  end

  def hint_options
    options[:hint_options] || {}
  end

  def hint?
    hint_text.present?
  end

  def default_classes
    "space-y-1"
  end

  def input_class
    case type
    when :text then Form::TextField
    else
      raise "Type #{type} has no input_class. Add one."
    end
  end

  def render_field
    send("render_#{type}")
  end

  def render_text
    div(class: "flex flex-col gap-1") do
      render Form::Label.new(form:, method:, text: label_text, **label_options)
      render Form::TextField.new(form:, method:, data:, **input_options)
    end
  end
end
