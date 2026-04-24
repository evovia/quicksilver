# frozen_string_literal: true

class UI::ComponentPreview < UI::Base
  register_output_helper :markdownify

  prop :name, String, reader: :private

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

    div(class: "group") do
      div(class: "not-prose flex items-center justify-end mb-2") do
        menu(class: "flex items-center justify-end p-1 border border-gray-200 rounded-full gap-2") do
          li class: "px-2 py-1 text-sm font-medium text-gray-600 border border-transparent rounded-full hover:border-gray-900 hover:bg-gray-900 hover:text-white group-has-[[data-tab='1']]:bg-gray-900 group-has-[[data-tab='1']]:border-gray-900 group-has-[[data-tab='1']]:text-white" do
            button(data_action: "addDataAttribute#tab=1", data_target: "tabs") do
              "Preview"
            end
          end

          li class: "px-2 py-1 text-sm font-medium text-gray-600 border border-transparent rounded-full hover:border-gray-900 hover:bg-gray-900 hover:text-white group-has-[[data-tab='2']]:bg-gray-900 group-has-[[data-tab='2']]:border-gray-900 group-has-[[data-tab='2']]:text-white" do
            button(data_action: "addDataAttribute#tab=2", data_target: "tabs") do
              "Implementation"
            end
          end
        end
      end

      ul(id: "tabs", data_tab: "1", class: "border border-gray-200 rounded-lg overflow-hidden") do
        li(class: "hidden [[data-tab='1']_&]:flex not-prose min-h-80 justify-center items-center") do
          div(class: "mx-auto min-w-[60%]") do
            @preview_block.call
          end
        end

        li(class: "hidden [[data-tab='2']_&]:block") do
          markdownify <<~MARKDOWN
            ```ruby
            #{extract_view_template_body}
            ```
          MARKDOWN
        end
      end
    end
  end

  private

  def extract_view_template_body
    source = @code_block.call
    lines = source.lines
    start = lines.index { |l| l =~ /def view_template/ }
    return source unless start

    indent = lines[start][/^\s*/].length
    body = lines[(start + 1)..].take_while { |l| !(l.rstrip =~ /^\s{#{indent}}end$/) }
    body.map { |l| l.delete_prefix(" " * (indent + 2)) }.join.chomp
  end
end
