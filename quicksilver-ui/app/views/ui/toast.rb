# frozen_string_literal: true

class UI::Toast < UI::Base
  AUTO_DISMISS_DELAY = 8000

  prop :dismissable, _Boolean, default: true, reader: :private
  prop :auto_dismiss, _Boolean, default: true, reader: :private
  prop :variant, _Union("neutral", "danger"),
    default: :neutral, reader: :private do |value|
    value.to_s.inquiry
  end

  def initialize(**props)
    super
    @action = nil
  end

  def view_template
    output(
      data: {
        controller: "dismissable",
        dismissable_auto_dismiss_time_value: auto_dismiss_delay
      },
      class: classes
    ) do
      div class: "w-full min-h-8 py-1 px-2 inline-flex items-start justify-between gap-6" do
        span(class: "mt-0.5") { yield }

        span(class: "flex items-center gap-x-6") do
          render_action

          if dismissable?
            button data: {action: "dismissable#dismiss"}, class: button_classes do
              Icon(name: :x_mark, variant: :outline, class: "mt-px")
            end
          end
        end
      end
    end
  end

  def action(href:, text:)
    @action = {href:, text:}
    nil
  end

  private

  def render_action
    return if @action.nil?

    link_to @action[:text], @action[:href], class: action_classes
  end

  def dismissable?
    dismissable
  end

  def auto_dismiss?
    dismissable? && auto_dismiss
  end

  def auto_dismiss_delay
    AUTO_DISMISS_DELAY if auto_dismiss?
  end

  def default_classes
    class_names(
      "min-w-96 max-w-lg block text-sm font-medium ring shadow-xl",
      "bg-gray-50 text-gray-900 ring-gray-300": variant.neutral?,
      "bg-red-500 text-white ring-red-700": variant.danger?
    )
  end

  def button_classes
    class_names(
      "p-1 focus:outline-none",
      "text-gray-900 hover:bg-gray-200 focus:bg-gray-200 active:bg-gray-300": variant.neutral?,
      "text-white hover:bg-red-500 focus:bg-red-500 active:bg-red-400": variant.danger?
    )
  end

  def action_classes
    class_names(
      "py-0.5 px-1 focus:outline-none border text-xs",
      "border-gray-700 hover:border-gray-900 hover:bg-gray-200 focus:border-gray-900 focus:bg-gray-200 active:bg-gray-300": variant.neutral?,
      "border-red-300 hover:bg-red-600 hover:border-red-100 focus:bg-red-600 focus:border-red-100 active:bg-red-700 active:border-red-100": variant.danger?
    )
  end
end
