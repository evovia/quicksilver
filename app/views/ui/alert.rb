# frozen_string_literal: true

class UI::Alert < UI::Base
  prop :icon, _Union?(String, Symbol), predicate: :private, reader: :private
  prop :heading, String, reader: :private
  prop :description, _String?, predicate: :private, reader: :private
  prop :variant, _Union("neutral", "brand", "success", "warning", "danger", "info"),
    default: :info, reader: :private do |value|
    value.to_s.inquiry
  end
  prop :size, _Union("sm", "md"),
    default: :md, reader: :private do |value|
    value.to_s.inquiry
  end
  prop :dismissable, _Boolean, default: false, predicate: :private, reader: :private

  def view_template
    div(class: classes, data: data_with_defaults, role: :alert) do
      render Icon(name: icon, size:, class: "shrink-0 mt-1 #{icon_color_classes}") if icon?
      div(class: "w-full") do
        div(class: "flex items-center justify-between gap-2") do
          h5(class: heading_classes) { heading }

          if dismissable?
            button data: {action: "dismissable#dismiss"} do
              render UI::Icon.new(name: :x_mark, size:, class: "cursor-pointer #{icon_color_classes}")
            end
          end
        end

        p(class: description_classes) { description } if description?

        if block_given?
          div(class: description_classes) do
            yield
          end
        end
      end
    end
  end

  private

  def default_classes
    "ui-alert ui-alert-#{variant} ui-alert-#{size}"
  end

  def icon_color_classes
    class_names(
      "text-turqoise-900": variant.brand?,
      "text-emerald-800": variant.success?,
      "text-amber-800": variant.warning?,
      "text-red-800": variant.danger?,
      "text-blue-800": variant.info?
    )
  end

  def heading_classes
    class_names(
      "text-gray-950",
      "ui-text-md": size.md?,
      "ui-text-sm": size.sm?,
      "font-medium": description?
    )
  end

  def description_classes
    class_names(
      "text-gray-950",
      "ui-text-md": size.md?,
      "ui-text-sm": size.sm?
    )
  end

  def data_with_defaults
    data.with_defaults(
      dismissable? ? {controller: "dismissable"} : {}
    )
  end
end
