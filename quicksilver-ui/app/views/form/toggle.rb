# frozen_string_literal: true

class Form::Toggle < Form::Checkbox
  def view_template
    label for: options[:id] || id, class: classes do
      input(type: :hidden, name:, value: hidden_value) if include_hidden
      input(type: :checkbox, class: "hidden", data:, **options_with_defaults)

      div class: toggle_classes do
        render UI::Icon.new(name: :x_mark, size: :xs, class: "group-has-checked:hidden")
        render UI::Icon.new(name: :check, size: :xs, class: "hidden group-has-checked:block")
      end
    end
  end

  private

  def default_classes
    "group relative shrink-0 h-4 w-8 block ring ring-gray-800 bg-gray-300
    transition-colors has-disabled:bg-gray-100 has-disabled:ring-gray-300
    hover:bg-gray-400 has-checked:bg-gray-900 has-checked:ring-gray-900
    has-checked:hover:bg-gray-700 has-checked:hover:ring-gray-700
    has-checked:has-disabled:hover:bg-gray-100
    has-checked:has-disabled:hover:ring-gray-300"
  end

  def toggle_classes
    "absolute inline-flex items-center justify-center size-4 ring ring-gray-800
    bg-white transition-all group-has-checked:ring-gray-900
    group-has-checked:translate-x-full group-has-disabled:ring-gray-300
    group-has-disabled:bg-gray-200 group-has-checked:group-hover:ring-gray-700
    group-has-disabled:text-gray-600
    group-has-checked:group-has-disabled:group-hover:ring-gray-400"
  end
end
