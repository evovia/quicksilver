class Previews::Badge < Previews::Base
  def default
    render UI::Badge.new(text: "Details about things")
  end

  def with_icon
    render UI::Badge.new(text: "Details about things", icon: :heart)
  end

  def sizes_and_variants
    div class: "flex gap-2" do
      [:neutral, :brand, :danger].each do |variant|
        div do
          render UI::Badge.new(text: "Text", size: :sm, variant:)
          render UI::Badge.new(text: "Text", size: :md, variant:)
          render UI::Badge.new(text: "Text", size: :lg, variant:)
        end
      end
    end
  end

  def sizes_and_variants_and_icons
    div class: "flex gap-2" do
      [:neutral, :brand, :danger].each do |variant|
        div do
          render UI::Badge.new(icon: :heart, text: "Text", size: :sm, variant:)
          render UI::Badge.new(icon: :heart, text: "Text", size: :md, variant:)
          render UI::Badge.new(icon: :heart, text: "Text", size: :lg, variant:)
        end
      end
    end
  end
end
