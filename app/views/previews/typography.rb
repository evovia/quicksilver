class Previews::Typography < Previews::Base
  LOREM = "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus " \
    "ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus " \
    "duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus " \
    "fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada " \
    "lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti " \
    "sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos."

  SCENARIOS = {
    display_2xl: {class_name: "ui-display-2xl", text: "Display"},
    display_xl: {class_name: "ui-display-xl", text: "Display"},
    display_lg: {class_name: "ui-display-lg", text: "Display"},
    display_md: {class_name: "ui-display-md", text: "Display"},
    display_sm: {class_name: "ui-display-sm", text: "Display"},
    display_xs: {class_name: "ui-display-xs", text: "Display"},
    heading_2xl: {class_name: "ui-heading-2xl", text: "Heading"},
    heading_xl: {class_name: "ui-heading-xl", text: "Heading"},
    heading_lg: {class_name: "ui-heading-lg", text: "Heading"},
    heading_md: {class_name: "ui-heading-md", text: "Heading"},
    heading_sm: {class_name: "ui-heading-sm", text: "Heading"},
    heading_xs: {class_name: "ui-heading-xs", text: "Heading"},
    text_xl: {class_name: "ui-text-xl", text: :lorem},
    text_lg: {class_name: "ui-text-lg", text: :lorem},
    text_md: {class_name: "ui-text-md", text: :lorem},
    text_sm: {class_name: "ui-text-sm", text: :lorem},
    text_xs: {class_name: "ui-text-xs", text: :lorem},
    text_xl_medium: {class_name: "ui-text-xl-medium", text: :lorem},
    text_lg_medium: {class_name: "ui-text-lg-medium", text: :lorem},
    text_md_medium: {class_name: "ui-text-md-medium", text: :lorem},
    text_sm_medium: {class_name: "ui-text-sm-medium", text: :lorem},
    text_xs_medium: {class_name: "ui-text-xs-medium", text: :lorem},
    text_xl_semibold: {class_name: "ui-text-xl-semibold", text: :lorem},
    text_lg_semibold: {class_name: "ui-text-lg-semibold", text: :lorem},
    text_md_semibold: {class_name: "ui-text-md-semibold", text: :lorem},
    text_sm_semibold: {class_name: "ui-text-sm-semibold", text: :lorem},
    text_xs_semibold: {class_name: "ui-text-xs-semibold", text: :lorem}
  }

  SCENARIOS.each do |name, config|
    text = (config[:text] == :lorem) ? "LOREM" : config[:text].inspect
    define_method(name) do
      p(class: config[:class_name]) { (config[:text] == :lorem) ? LOREM : config[:text] }
    end
  end

  def self.scenarios
    SCENARIOS.keys
  end

  def code_for(method_name)
    config = SCENARIOS[method_name]
    return super unless config

    text = (config[:text] == :lorem) ? "LOREM" : config[:text].inspect
    %{p(class: "#{config[:class_name]}") { #{text} }}
  end
end
