class Previews::Checkbox < Previews::Base
  def default
    app_form_with(url: "#") do |form|
      form.checkbox :something_1
    end
  end

  def checked
    app_form_with(url: "#") do |form|
      form.checkbox :something_2, checked: true
    end
  end

  def disabled
    app_form_with(url: "#") do |form|
      form.checkbox :something_3, disabled: true
    end
  end

  def disabled_and_checked
    app_form_with(url: "#") do |form|
      form.checkbox :something, checked: true, disabled: true
    end
  end
end
