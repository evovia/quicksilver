class Previews::Avatar < Previews::Base
  def initials
    render UI::Avatar.new(initials: "NW")
  end

  def image_with_initials_fallback
    render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format")
  end

  def sizes
    div class: "space-x-2" do
      render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format", size: :xs)
      render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format", size: :sm)
      render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format", size: :md)
      render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format", size: :lg)
      render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format", size: :xl)
      render UI::Avatar.new(initials: "NW", image_url: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100&auto=format", size: :xxl)
    end
  end
end
