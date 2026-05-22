# frozen_string_literal: true

class UI::Accordion < UI::Base
  prop :content_class, _Nilable(String), reader: :private
  prop :size, _Union("sm", "md", "lg"), default: :md, reader: :private do |value|
    value.to_s.inquiry
  end

  def initialize(**props)
    super
    @items = []
  end

  def item(heading:, open: false, icon: nil, &block)
    @items << {heading:, open:, icon:, block:}
    nil
  end

  def view_template(&block)
    vanish(&block) if block_given?

    div(class: classes) do
      @items.each do |item|
        details(class: "group", open: item[:open]) do
          summary(class: summary_classes) do
            span(class: "inline-flex items-center gap-2") do
              plain item[:heading]
            end

            div(class: "text-gray-900") do
              render Icon(name: :chevron_down, variant: "outline", class: "size-3 block transition-all duration-300 group-open:rotate-180")
            end
          end
          div(class: content_classes) do
            item[:block].call
          end
        end
      end
    end
  end

  private

  def default_classes
    "max-w-lg divide-y divide-gray-200 bg-white rounded-lg"
  end

  def summary_classes
    class_names(
      "flex cursor-pointer list-none items-center justify-between text-primary-900",
      "py-2 px-3 text-lg font-medium": size.lg?,
      "py-1 px-2 text-sm": size.md?,
      "py-1 px-1.5 text-sm": size.sm?
    )
  end

  def content_classes
    TAILWIND_MERGER.merge(
      [class_names(
        "text-gray-900",
        "pb-4 px-3": size.lg?,
        "pb-2 px-2 text-sm": size.md?,
        "pb-1 px-1.5 text-xs": size.sm?
      ), content_class].join(" ")
    )
  end
end
