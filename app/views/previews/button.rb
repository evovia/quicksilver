class Previews::Button < Previews::Base
  def initialize(name:, text:, classes:)
    @name = name
    @text = text
    @classes = classes
  end

  attr_reader :classes

  def view_template
    button(class: classes) { @text }
  end

  def to_code
    "button(class: \"#{classes}\") { \"#{@text}\" }"
  end
end
