class Previews::Tag < Previews::Base
  def medium
    render UI::Tag.new(text: "Tag", size: :md)
  end

  def small
    render UI::Tag.new(text: "Tag", size: :sm)
  end
end
