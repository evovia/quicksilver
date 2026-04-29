class Previews::Submit < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.submit
    end
  end
end
