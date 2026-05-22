class Sidebar::Category < UI::Base
  include Phlex::Rails::Helpers::CurrentPage

  prop :heading, String, reader: :private
  prop :items, Array, reader: :private
  prop :text_method, Symbol, default: :title, reader: :private

  def view_template
    div do
      h5(class: "font-medium text-lg") { heading }
      menu do
        items.each do |item|
          render_item(item)
        end
      end
    end
  end

  private

  def render_item(item)
    li do
      link_to(
        item.public_send(text_method),
        item,
        class: class_names("ui-link", "font-medium text-primary-500": current_page?(item))
      )
    end
  end
end
