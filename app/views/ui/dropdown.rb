# frozen_string_literal: true

class UI::Dropdown < UI::Base
  prop :heading, _Nilable(String), reader: :private
  prop :offset, Integer, default: 8, reader: :private
  prop :placement,
    _Union("top", "top-start", "top-end", "right", "right-start", "right-end", "bottom", "bottom-start", "bottom-end", "left", "left-start", "left-end"),
    reader: :private, default: "bottom-end"

  def initialize(**props)
    super
    @items = []
    @trigger_block = nil
    @action_block = nil
  end

  def item(href:, icon: nil, trailing_icon: nil, method: :get, &block)
    @items << {href:, icon:, trailing_icon:, method:, block:}
    nil
  end

  def action(&block)
    @action_block = block if block_given?
    nil
  end

  def trigger(class: nil, &block)
    @trigger_block = block
    @trigger_classes = grab(class:)
    nil
  end

  def view_template(&block)
    vanish(&block) if block_given?

    div(data: {controller: "dropdown", dropdown_offset_value: offset, dropdown_placement_value: placement}, class: classes) do
      render_trigger

      div(
        data: {
          dropdown_target: "menu",
          transition_enter_from: "opacity-0 scale-95",
          transition_enter_to: "opacity-100 scale-100",
          transition_leave_from: "opacity-100 scale-100",
          transition_leave_to: "opacity-0 scale-95"
        },
        class:
          "hidden transition transform origin-top-left absolute left-0 top-0 z-50"
      ) do
        div(class: "w-64 bg-white shadow-xs border border-gray-300
        inline-flex flex-col justify-start items-start overflow-hidden") do
          render_heading

          div(class: "w-full flex flex-col justify-start items-start gap-1") do
            @items.each do |item_data|
              render Dropdown::Item.new(
                **item_data.except(:block),
                &item_data[:block]
              )
            end
          end
        end
      end
    end
  end

  private

  def render_trigger
    button(class: trigger_classes, data: {action: "dropdown#toggle click@window->dropdown#hide"}) do
      @trigger_block.call
    end
  end

  def render_heading
    return unless heading.present? || action?

    div(class: "w-full px-4 py-2 border-b border-gray-300 flex justify-between
      items-center gap-4") do
      if heading.present?
        div(class: "ui-text-sm-medium") do
          heading
        end
      end

      render_action
    end
  end

  def render_action
    div(class: "ui-text-xs text-gray-700") do
      @action_block&.call
    end
  end

  def default_classes
    "relative"
  end

  def trigger_classes
    TAILWIND_MERGER.merge [default_trigger_classes, @trigger_classes].join(" ")
  end

  def default_trigger_classes
    "focus:outline-none active:outline-none"
  end

  def action?
    @action_block.present?
  end
end
