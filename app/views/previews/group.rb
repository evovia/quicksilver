class Previews::Group < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.group :name
    end
  end

  def with_overriden_label
    app_form_with url: "#" do |form|
      form.group :name, label: "Overriden Text"
    end
  end

  def with_hint
    app_form_with url: "#" do |form|
      form.group :name, hint: "This is a hint"
    end
  end
end
