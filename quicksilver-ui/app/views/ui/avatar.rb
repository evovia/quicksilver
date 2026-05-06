# frozen_string_literal: true

class UI::Avatar < UI::Base
  include Phlex::Rails::Helpers::ImageTag

  prop :initials, String, reader: :private
  prop :image_url, _Nilable(String), reader: :private
  prop :size, _Union("xs", "sm", "md", "lg", "xl", "xxl"), default: :md, reader: :private do |value|
    value.to_s.inquiry
  end

  def view_template
    span(class: classes) do
      if image_url.present?
        image_tag(image_url, class: "size-full rounded-full object-cover")
      else
        span(class: text_classes) { initials }
      end
    end
  end

  private

  def classes
    class_names(
      super,
      size_classes
    )
  end

  def default_classes
    "inline-flex size-6 items-center justify-center rounded-full bg-brand-turqoise-100 border border-brand-turqoise-700"
  end

  def size_classes
    class_names(
      "size-6": size.xs?,
      "size-8": size.sm?,
      "size-10": size.md?,
      "size-12": size.lg?,
      "size-14": size.xl?,
      "size-16": size.xxl?
    )
  end

  def text_classes
    class_names(
      "font-medium text-brand-turqoise-900 uppercase",
      "text-xs": size.xs?,
      "text-sm": size.sm?,
      "text-base": size.md?,
      "text-xl": size.lg? || size.xl?,
      "text-2xl": size.xxl?,
      hidden: image_url.present?
    )
  end
end
