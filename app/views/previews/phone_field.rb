class Previews::PhoneField < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.phone_field :phone
    end
  end

  def with_value
    app_form_with url: "#" do |form|
      form.phone_field :phone, value: "12341234"
    end
  end
end
