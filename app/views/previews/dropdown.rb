class Previews::Dropdown < Previews::Base
  def default
    render UI::Dropdown.new(heading: "Heading up", placement: "bottom-start") do |dropdown|
      dropdown.trigger(class: "ui-button ui-button-neutral") do
        "Clickety clackety"
      end

      dropdown.item(href: "/") { "Item 1" }
      dropdown.item(href: "/somewhere", icon: :heart) { "Item 2" }
      dropdown.item(href: "/else", trailing_icon: :heart) { "Item 3" }
      dropdown.item(href: "/amazing") { "Item 4" }
    end
  end

  def with_action
    render UI::Dropdown.new(heading: "Heading up", placement: "bottom-start") do |dropdown|
      dropdown.trigger(class: "ui-button ui-button-primary") do
        "Clickety clackety"
      end

      dropdown.action { "Do stuff" }

      dropdown.item(href: "/") { "Item 1" }
      dropdown.item(href: "/somewhere", icon: :heart) { "Item 2" }
      dropdown.item(href: "/else", trailing_icon: :heart) { "Item 3" }
      dropdown.item(href: "/amazing") { "Item 4" }
    end
  end
end
