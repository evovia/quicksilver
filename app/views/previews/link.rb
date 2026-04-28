class Previews::Link < Previews::Base
  def initialize(name:, text:, classes:)
    @name = name
    @text = text
    @classes = classes
  end

  attr_reader :classes

  def view_template
    a(href: "#", class: classes) { @text }
  end

  def to_code
    "a(href: \"#\", class: \"#{classes}\") { \"#{@text}\" }"
  end
end
