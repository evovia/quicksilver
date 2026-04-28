class Previews::Icon < Previews::Base
  def default
    render UI::Icon.new(name: :academic_cap)
  end

  def sizes
    render UI::Icon.new(name: :academic_cap, size: :xs)
    render UI::Icon.new(name: :academic_cap, size: :sm)
    render UI::Icon.new(name: :academic_cap, size: :md)
    render UI::Icon.new(name: :academic_cap, size: :lg)
    render UI::Icon.new(name: :academic_cap, size: :xl)
    render UI::Icon.new(name: :academic_cap, size: :xxl)
  end

  def styles
    render UI::Icon.new(name: :academic_cap, variant: :micro, size: :sm)
    render UI::Icon.new(name: :academic_cap, variant: :mini, size: :md)
    render UI::Icon.new(name: :academic_cap, variant: :outline, size: :lg)
    render UI::Icon.new(name: :academic_cap, variant: :solid, size: :lg)
  end

  def spin
    render UI::Icon.new(name: :cog_6_tooth, spin: true, size: :xxl)
  end

  def colors
    render UI::Icon.new(name: :academic_cap, variant: :micro, size: :sm, class: "text-amber-500")
    render UI::Icon.new(name: :academic_cap, variant: :mini, size: :md, class: "text-emerald-500")
    render UI::Icon.new(name: :academic_cap, variant: :outline, size: :lg, class: "text-red-500")
    render UI::Icon.new(name: :academic_cap, variant: :solid, size: :lg, class: "text-indigo-500")
  end
end
