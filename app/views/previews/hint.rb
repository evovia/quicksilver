class Previews::Hint < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.hint :name, "Take the hint..."
    end
  end
end
