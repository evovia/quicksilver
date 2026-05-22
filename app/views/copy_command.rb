# frozen_string_literal: true

class CopyCommand < Phlex::HTML
  include Phlex::Rails::Helpers::ClassNames
  include RailsIcons::Helpers::IconHelper

  def initialize(command:)
    @command = command
    @id = "copy-cmd-#{Random.hex(4)}"
  end

  def view_template
    div(
      class: "group/copy relative inline-flex items-center gap-2 rounded-lg bg-gray-100 border border-gray-200 px-3 py-2 font-mono text-sm"
    ) do
      span(id: @id) { @command }

      button(
        type: "button",
        class: "text-gray-500 hover:text-gray-900 cursor-pointer",
        data_action: "copy",
        data_target: @id
      ) do
        render UI::Icon.new(name: :document_duplicate, class: "size-4 block group-has-data-[copy-success=true]/copy:hidden")
        render UI::Icon.new(name: :document_check, class: "size-4 hidden group-has-data-[copy-success=true]/copy:block")
      end
    end
  end
end
