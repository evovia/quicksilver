# frozen_string_literal: true

class UI::Dropdown::Item < UI::Base
  prop :href, String, reader: :private
  prop :icon, _Nilable(Symbol), reader: :private
  prop :trailing_icon, _Nilable(Symbol), reader: :private
  prop :method, _Union(Symbol, String), default: :get, reader: :private

  def view_template(&)
    tag do
      render Icon(name: icon, class: "text-gray-500") if icon?

      div class: text_classes do
        yield
      end

      render Icon(name: trailing_icon, class: "text-gray-500") if trailing_icon?
    end
  end

  private

  def tag(&)
    if method == :get
      a href:, class: classes, &
    else
      button_to href, method:, form_class: classes, class: "flex items-center gap-3 w-full", &
    end
  end

  def icon?
    icon.present?
  end

  def trailing_icon?
    trailing_icon.present?
  end

  def text_classes
    "ui-text-sm flex-1"
  end

  def default_classes
    class_names(
      "self-stretch flex justify-start items-center flex-1 px-4 py-2 gap-3",
      "hover:bg-gray-100 focus:bg-gray-100 active:bg-gray-200"
    )
  end
end
