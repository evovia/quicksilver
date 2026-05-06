# frozen_string_literal: true

class UI::Modal < UI::Base
  prop :open, _Boolean, default: false, reader: :private
  prop :heading, String, reader: :private
  prop :text, _Nilable(String), reader: :private
  prop :backdrop_closeable, _Boolean, default: true, reader: :private

  def initialize(**props)
    super
    @trigger_block = nil
    @footer_block = nil
  end

  def view_template(&block)
    vanish(&block) if block_given?

    div data: {controller: "modal", modal_open_value: open}.merge(backdrop_closeable_attributes) do
      dialog(data: {modal_target: "dialog"}, class: classes) do
        div(class: "ui-modal-body") do
          div(class: "flex justify-between items-start") do
            render_heading
            render_close_trigger
          end
          render_text

          yield
        end

        render_footer
      end

      render_trigger
    end
  end

  def trigger(class: nil, &block)
    @trigger_block = block
    @trigger_classes = grab(class:)
    nil
  end

  def footer(class: nil, &block)
    @footer_block = block
    @footer_classes = grab(class:)
    nil
  end

  private

  def render_close_trigger
    button(data: {action: "modal#close"}, class: "cursor-pointer hover:text-gray-700") do
      render UI::Icon.new(name: :x_mark)
    end
  end

  def render_heading
    h2(class: "ui-display-md") { heading }
  end

  def render_text
    p(class: "ui-text-md") { text }
  end

  def render_footer
    return if @footer_block.nil?

    div(class: footer_classes) do
      @footer_block.call
    end
  end

  def render_trigger
    button(class: @trigger_classes, data: {action: "modal#open"}) do
      @trigger_block.call
    end
  end

  def backdrop_closeable_attributes
    return {action: "click->modal#backdropClose"} if backdrop_closeable?

    {}
  end

  def backdrop_closeable?
    backdrop_closeable
  end

  def default_classes
    "ui-modal"
  end

  def footer_classes
    TAILWIND_MERGER.merge ["ui-modal-footer", @footer_classes].join(" ")
  end
end
