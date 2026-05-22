class Previews::Textarea < Previews::Base
  def default
    app_form_with url: "#" do |form|
      form.textarea :description
    end
  end

  def autogrow
    app_form_with url: "#" do |form|
      form.textarea :description, value: "Bypasses are devices that allow some people to dash from point A to point B very fast while other people dash from point B to point A very fast. People living at point C, being a point directly in between, are often given to wonder what's so great about point A that so many people from point B are so keen to get there, and what's so great about point B that so many people from point A are so keen to get there. They often wish that people would just once and for all work out where the hell they wanted to be.", autogrow: true
    end
  end

  def with_rows
    app_form_with url: "#" do |form|
      form.textarea :description, rows: 8, value: "Bypasses are devices that allow some people to dash from point A to point B very fast while other people dash from point B to point A very fast. People living at point C, being a point directly in between, are often given to wonder what's so great about point A that so many people from point B are so keen to get there, and what's so great about point B that so many people from point A are so keen to get there. They often wish that people would just once and for all work out where the hell they wanted to be."
    end
  end
end
