class Previews::Typography < Previews::Base
  def initialize(name:, text:)
    @name = name
    @text = text
  end

  def view_template
    p(class: @name) { @text }
  end

  def to_code
    "p(class: \"#{@name}\") { \"#{@text}\" }"
  end
end
