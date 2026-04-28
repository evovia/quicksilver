# frozen_string_literal: true

class UI::Preview < UI::Base
  register_output_helper :markdownify

  VARIANTS = {
    component: {li_class: "min-h-80 justify-center items-center", wrapper_class: "mx-auto min-w-[60%]"},
    affordance: {li_class: "min-h-20 px-4 py-2 items-center", wrapper_class: nil}
  }

  prop :heading, _String?, predicate: :private, reader: :private
  prop :variant, Symbol, default: -> { :component }, reader: :private

  def preview(&block)
    @preview_block = block
    nil
  end

  def code(&block)
    @code_block = block
    nil
  end

  def view_template(&block)
    vanish(&block) if block_given?

    div(data_controller: "tabs", data_tabs_active_value: "preview", class: "mb-6") do
      div(class: class_names("not-prose flex items-center mb-2", "justify-between": heading?, "justify-end": !heading?)) do
        h2(class: "ui-heading-md") { heading } if heading?
        menu(class: "flex items-center justify-end p-1 border border-gray-200 rounded-full gap-2") do
          render_tab_button(text: "Preview", tab: "preview")
          render_tab_button(text: "Implementation", tab: "implementation")
        end
      end

      div(class: "border border-gray-200 rounded-lg overflow-hidden") do
        div(data_tabs_target: "panel", data_tab: "preview", class: "flex not-prose #{variant_config[:li_class]}") do
          if variant_config[:wrapper_class]
            div(class: variant_config[:wrapper_class]) { @preview_block.call }
          else
            @preview_block.call
          end
        end

        div(data_tabs_target: "panel", data_tab: "implementation", class: "hidden") do
          markdownify <<~MARKDOWN
            ```ruby
            #{@code_block.call}
            ```
          MARKDOWN
        end
      end
    end
  end

  private

  def variant_config
    VARIANTS.fetch(variant)
  end

  def render_tab_button(text:, tab:)
    li do
      button(
        data_tabs_target: "tab",
        data_action: "tabs#switch",
        data_tabs_tab_param: tab,
        class: "px-2 py-1 text-sm font-medium text-gray-600 border border-transparent rounded-full hover:border-gray-900 hover:bg-gray-900 hover:text-white"
      ) do
        text
      end
    end
  end
end
