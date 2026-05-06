# frozen_string_literal: true

class Previews::Modal < Previews::Base
  def default
    render UI::Modal.new(heading: "Title", text: "Qui in quis Lorem velit esse tempor laboris enim id sint commodo Lorem. Magna voluptate dolore ex elit anim. Aliqua fugiat qui incididunt incididunt sit deserunt mollit labore eiusmod elit officia est nisi. Elit est nostrud ut adipisicing ex esse aliquip incididunt minim ad ex sit. Ut aliqua adipisicing esse reprehenderit sit sit incididunt duis consectetur ad. Laborum ea consectetur pariatur aliqua sit cupidatat pariatur consectetur aute reprehenderit eiusmod veniam. Laboris deserunt consequat occaecat enim eiusmod et aliquip minim.") do |modal|
      modal.trigger(class: "ui-button") do
        "Pop pop!"
      end

      modal.footer do
        div(class: "flex justify-between") do
          button(class: "ui-button") { "Button #3" }

          div(class: "flex gap-x-3") do
            button(class: "ui-button") { "Button #1" }
            button(class: "ui-button ui-button-primary") { "Button #2" }
          end
        end
      end
    end
  end

  def with_yielded_content
    render UI::Modal.new(heading: "Title") do |modal|
      modal.trigger(class: "ui-button") do
        "Pop pop!"
      end

      render UI::Alert.new(
        icon: "exclamation-triangle",
        heading: "You can render anything here",
        description: "Like other components",
        variant: :warning
      )

      p { "Or just plain HTML" }
    end
  end

  def not_backdrop_closeable
    render UI::Modal.new(heading: "Title", text: "Qui in quis Lorem velit esse tempor laboris enim id sint commodo Lorem. Magna voluptate dolore ex elit anim. Aliqua fugiat qui incididunt incididunt sit deserunt mollit labore eiusmod elit officia est nisi. Elit est nostrud ut adipisicing ex esse aliquip incididunt minim ad ex sit. Ut aliqua adipisicing esse reprehenderit sit sit incididunt duis consectetur ad. Laborum ea consectetur pariatur aliqua sit cupidatat pariatur consectetur aute reprehenderit eiusmod veniam. Laboris deserunt consequat occaecat enim eiusmod et aliquip minim.", backdrop_closeable: false) do |modal|
      modal.trigger(class: "ui-button") do
        "Pop pop!"
      end
    end
  end
end
