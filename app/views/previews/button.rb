class Previews::Button < Previews::Base
  def default
    button(class: "ui-button") { "Click Me!" }
  end

  def primary
    button(class: "ui-button ui-button-primary") { "Click Me!" }
  end

  def secondary
    button(class: "ui-button ui-button-secondary") { "Click Me!" }
  end

  def warning
    button(class: "ui-button ui-button-warning") { "Click Me!" }
  end

  def danger
    button(class: "ui-button ui-button-danger") { "Click Me!" }
  end

  def large
    button(class: "ui-button ui-button-lg") { "Click Me!" }
  end

  def medium
    button(class: "ui-button ui-button-md") { "Click Me!" }
  end

  def small
    button(class: "ui-button ui-button-sm") { "Click Me!" }
  end

  def extra_small
    button(class: "ui-button ui-button-xs") { "Click Me!" }
  end
end
