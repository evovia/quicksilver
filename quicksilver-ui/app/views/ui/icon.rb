# frozen_string_literal: true

class UI::Icon < UI::Base
  register_output_helper :icon

  prop :size, _Union("xs", "sm", "md", "lg", "xl", "xxl"), default: :md, reader: :private do |value|
    value.to_s.inquiry
  end
  prop :variant, _Union("micro", "mini", "outline", "solid"), default: :outline, reader: :private do |value|
    value.to_s.inquiry
  end
  prop :name, String, reader: :private do |value|
    value.to_s.dasherize
  end
  prop :fixed_width, _Boolean, default: true, reader: :private
  prop :spin, _Boolean, default: false, reader: :private

  def view_template
    icon(name, class: classes, variant:)
  end

  private

  def size_classes
    class_names(
      "size-2": size.xs?,
      "size-3": size.sm?,
      "size-4": size.md?,
      "size-6": size.lg?,
      "size-8": size.xl?,
      "size-10": size.xxl?
    )
  end

  def spin_classes
    "animate-spin" if spin
  end

  def default_classes
    class_names(
      "text-inherit",
      size_classes,
      spin_classes
    )
  end
end
