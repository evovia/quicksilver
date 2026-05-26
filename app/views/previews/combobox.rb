class Previews::Combobox < Previews::Base
  def one_choice_allowed
    app_form_with(url: "#") do |form|
      form.combobox(:user_id, DummyUser.all)
    end
  end

  def one_choice_allowed_with_existing_choice
    app_form_with(url: "#") do |form|
      form.combobox(:user_id, DummyUser.all, selected: DummyUser.first)
    end
  end

  def multiple_choices_allowed
    app_form_with(url: "#") do |form|
      form.combobox(:user_ids, DummyUser.all, multiple: true)
    end
  end

  def multiple_choices_allowed_with_existing_choices
    app_form_with(url: "#") do |form|
      form.combobox(:user_ids, DummyUser.all, multiple: true, selected: [DummyUser.first])
    end
  end
end
