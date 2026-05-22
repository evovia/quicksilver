class Previews::Toggle < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.toggle :with_mustard
    end
  end
end
