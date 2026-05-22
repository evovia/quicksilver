class Previews::FileField < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.file_field :name
    end
  end
end
