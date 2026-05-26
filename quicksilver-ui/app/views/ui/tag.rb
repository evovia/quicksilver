# frozen_string_literal: true

class UI::Tag < UI::Base
  prop :text, String, reader: :private
  prop :size, _Union("sm", "md"),
    default: :md, reader: :private do |value|
    value.to_s.inquiry
  end
  prop :button_data, Hash, default: {}.freeze, reader: :private

  def view_template
    div data:, class: classes do
      span(class: text_classes) { text }
      button type: :button, data: button_data_with_defaults, class: button_classes do
        render UI::Icon.new(name: :x_mark, class: icon_classes)
      end

      yield if block_given?
    end
  end

  private

  def data
    mix default_data, super
  end

  def default_classes
    class_names(
      "inline-flex items-center gap-1
      text-gray-950 border border-gray-400 bg-white",
      "py-1 pl-3 pr-2": size.md?,
      "py-0.5 pl-1.5 pr-1": size.sm?
    )
  end

  def text_classes
    return "ui-text-xs" if size.sm?

    "ui-text-sm" if size.md?
  end

  def button_data_with_defaults
    mix default_button_data, button_data
  end

  def button_classes
    "pl-0.5 text-primary-900 hover:text-primary-800
    cursor-pointer"
  end

  def icon_classes
    return "size-2.5" if size.sm?

    "size-3" if size.md?
  end

  def default_data
    {
      controller: "dismissable",
      transition_enter_active: "transition ease-out duration-300",
      transition_enter_from: "transform opacity-0 scale-10",
      transition_enter_to: "transform opacity-10 0 scale-100",
      transition_leave_active: "transition ease-in duration-300",
      transition_leave_from: "transform opacity-100 scale-100",
      transition_leave_to: "transform opacity-0 scale-10"
    }
  end

  def default_button_data
    {action: "dismissable#dismiss"}
  end
end
