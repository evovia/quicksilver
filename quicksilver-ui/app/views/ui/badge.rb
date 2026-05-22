# frozen_string_literal: true

class UI::Badge < UI::Base
  prop :text, String, reader: :private
  prop :icon, _Nilable(Symbol), reader: :private
  prop :variant, _Union("neutral", "brand", "danger"),
    default: :neutral, reader: :private do |value|
    value.to_s.inquiry
  end
  prop :size, _Union("sm", "md", "lg"),
    default: :md, reader: :private do |value|
    value.to_s.inquiry
  end

  def view_template
    div class: classes, data: do
      UI::Icon(name: icon, class: icon_classes, size: :sm) if icon.present?
      span { text }
    end
  end

  private

  def default_classes
    "ui-badge ui-badge-#{variant} ui-badge-#{size}"
  end

  def icon_classes
    class_names(
      "text-gray-700": variant.neutral?,
      "text-primary-700": variant.brand?,
      "text-red-400": variant.danger?
    )
  end
end
