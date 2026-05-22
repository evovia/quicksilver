class Previews::PasswordField < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.password_field :password
    end
  end

  def with_value
    app_form_with url: "#" do |form|
      form.password_field :password, value: "This is a secret"
    end
  end
end
