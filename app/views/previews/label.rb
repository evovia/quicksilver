class Previews::Label < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.label :name
    end
  end

  def with_overriden_text
    app_form_with url: "#" do |form|
      form.label :name, "Overriden Text"
    end
  end
end
