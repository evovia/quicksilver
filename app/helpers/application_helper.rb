module ApplicationHelper
  def render_component_implementation(name)
    File.read(Rails.root.join("app/views/ui/#{name}.rb")).html_safe
  end

  def render_affordance_implementation(name)
    File.read(Rails.root.join("app/assets/tailwind/#{name}.css")).html_safe
  end

  def render_form_implementation(name)
    File.read(Rails.root.join("app/views/form/#{name}.rb")).html_safe
  end

  def render_previews(name, variant: :component)
    preview_class = "Previews::#{name.classify}".constantize

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
end
