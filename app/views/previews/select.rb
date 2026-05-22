class Previews::Select < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.select :country, [["Denmark", "dk"], ["Sweden", "se"], ["Norway", "no"]]
    end
  end

  def with_selected
    app_form_with url: "#" do |form|
      form.select :country, [["Denmark", "dk"], ["Sweden", "se"], ["Norway", "no"]], selected: "no"
    end
  end

  def disabled
    app_form_with url: "#" do |form|
      form.select :country, [["Denmark", "dk"], ["Sweden", "se"], ["Norway", "no"]], {}, disabled: true
    end
  end
end
