class Form::Combobox::SelectedItem < Form::BaseTag
  prop :item, _Any, reader: :private
  prop :text_method, _Union(String, Symbol), default: :name, reader: :private
  prop :value_method, _Union(String, Symbol), default: :to_param, reader: :private

  def view_template
    render UI::Tag.new(text:, size: :sm, data: {combobox_target: "selectedItem"}) do
      input(
        type: "hidden",
        name: "#{name}[]",
        value:
      )
    end
  end

  private

  def text
    item.public_send(text_method)
  end

  def value
    item.public_send(value_method)
  end
end
