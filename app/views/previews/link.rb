class Previews::Link < Previews::Base
  def default
    a(href: "#", class: "ui-link") { "Link" }
  end

  def branded
    a(href: "#", class: "ui-link ui-link-primary") { "Link" }
  end

  def danger
    a(href: "#", class: "ui-link ui-link-danger") { "Link" }
  end

  def large
    a(href: "#", class: "ui-link ui-link-lg") { "Link" }
  end

  def medium
    a(href: "#", class: "ui-link ui-link-md") { "Link" }
  end

  def small
    a(href: "#", class: "ui-link ui-link-sm") { "Link" }
  end
end
