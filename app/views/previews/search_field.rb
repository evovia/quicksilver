class Previews::SearchField < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.search_field :name
    end
  end

  def with_value
    app_form_with url: "#" do |form|
      form.search_field :name, value: "Jonathan Doe"
    end
  end
end
