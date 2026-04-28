class Previews::Alert < Previews::Base
  def neutral
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :neutral
    )
  end

  def brand
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :brand
    )
  end

  def with_icon
    render UI::Alert.new(
      icon: :check_circle,
      heading: "Alert!",
      description: "This is not good...",
      variant: :brand
    )
  end

  def dismissable
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :brand,
      dismissable: true
    )
  end

  def success
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :success
    )
  end

  def warning
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :warning
    )
  end

  def danger
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :danger
    )
  end

  def info
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      variant: :info
    )
  end

  def sm
    render UI::Alert.new(
      heading: "Alert!",
      description: "This is not good...",
      size: :sm
    )
  end
end
