class Previews::RadioButton < Previews::Base
  def default
    app_form_with(url: "#") do |form|
      form.radio_button :something_1, :tag_value
    end
  end

  def checked
    app_form_with(url: "#") do |form|
      form.radio_button :something_2, :tag_value, checked: true
    end
  end

  def disabled
    app_form_with(url: "#") do |form|
      form.radio_button :something_3, :tag_value, disabled: true
    end
  end

  def disabled_and_checked
    app_form_with(url: "#") do |form|
      form.radio_button :something, :tag_value, checked: true, disabled: true
    end
  end
end
