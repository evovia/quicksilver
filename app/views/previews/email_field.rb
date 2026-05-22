class Previews::EmailField < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.email_field :email
    end
  end

  def with_value
    app_form_with url: "#" do |form|
      form.email_field :email, value: "email@example.com"
    end
  end

  def with_invalid_value
    app_form_with url: "#" do |form|
      form.email_field :email, value: "notvalid"
    end
  end
end
