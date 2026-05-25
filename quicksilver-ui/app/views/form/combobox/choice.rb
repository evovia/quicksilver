class Form::Combobox::Choice < UI::Base
  prop :choice, _Any, reader: :private
  prop :text_method, _Union(String, Symbol, _Lambda), default: :name, reader: :private
  prop :value_method, _Union(String, Symbol), default: :to_param, reader: :private

  def view_template
    li role: "option",
      class: choice_classes,
      data: {
        combobox_target: "choice",
        value: choice.public_send(value_method),
        action: "mousedown->combobox#preventBlur click->combobox#selectChoice"
      } do
      if text_method.respond_to?(:call)
        text_method.call(choice)
      else
        choice.public_send(text_method)
      end
    end
  end

  private

  def choice_classes
    class_names(
      "w-full px-3 py-2 gap-1 cursor-pointer",
      "hover:bg-gray-100 focus:bg-gray-100 active:bg-gray-200",
      "transition-colors duration-150",
      text_classes
    )
  end

  def text_classes
    "text-brand-turqoise-900 text-sm font-normal leading-5"
  end
end
