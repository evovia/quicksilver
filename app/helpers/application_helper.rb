module ApplicationHelper
  def render_component_implementation(name)
    path = QuicksilverUI.ui_path.join("#{name}.rb")
    File.read(path).html_safe if path.exist?
  end

  def render_affordance_implementation(name)
    path = Rails.root.join("app/assets/tailwind/#{name}.css")
    File.read(path).html_safe if path.exist?
  end

  def render_form_implementation(name)
    path = QuicksilverUI.form_path.join("#{name}.rb")
    File.read(path).html_safe if path.exist?
  end

  def render_previews(name, variant: :component)
    preview_class = "Previews::#{name.classify}".safe_constantize
    return "".html_safe unless preview_class

    safe_join(preview_class.scenarios.map do |scenario_name|
      content_tag :div, class: "prose-ul:p-0 prose-ul:m-0 prose-li:p-0 prose-li:m-0 prose-ul:leading-none prose-pre:my-0 prose-pre:bg-[#2b303b]" do
        preview_instance = preview_class.new.with_scenario(scenario_name)
        heading = scenario_name.to_s.humanize

        render UI::Preview.new(heading: heading, variant: variant) do |preview|
          preview.preview { render preview_instance }
          preview.code { preview_instance.code_for(scenario_name) }
        end
      end
    end)
  end

  def render_implementation(name, type:)
    implementation = case type
    when :component then render_component_implementation(name)
    when :form then render_form_implementation(name)
    when :affordance then render_affordance_implementation(name)
    end

    return unless implementation

    lang = (type == :affordance) ? "css" : "ruby"
    markdownify "```#{lang}\n#{implementation}\n```", process: [CopyableCodeProcessor]
  end
end
