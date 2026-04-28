class Previews::Accordion < Previews::Base
  def view_template
    render UI::Accordion.new do |accordion|
      accordion.item(heading: "Item 1") do
        p { "Content 1" }
      end
      accordion.item(heading: "Item 2") do
        p { "Content 2" }
      end
    end
  end
end
