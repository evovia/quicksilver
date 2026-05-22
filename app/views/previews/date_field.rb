class Previews::DateField < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.date_field :birthdate
    end
  end

  def with_datetime_value
    app_form_with url: "#" do |form|
      form.date_field :birthdate, value: 20.years.ago
    end
  end

  def with_string_value
    app_form_with url: "#" do |form|
      form.date_field :birthdate, value: "2022-12-01"
    end
  end
end
