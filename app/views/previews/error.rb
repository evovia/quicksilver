class Previews::Error < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.error :name, "You did something bad and you should feel bad"
    end
  end
end
