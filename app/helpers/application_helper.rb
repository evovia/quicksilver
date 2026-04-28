module ApplicationHelper
  def implementation_of(name)
    File.read(Rails.root.join("app/views/ui/#{name}.rb")).html_safe
  end

  def render_component_preview(name)
    content_tag :div, class: "prose-ul:p-0 prose-ul:m-0 prose-li:p-0 prose-li:m-0 prose-ul:leading-none prose-pre:my-0 prose-pre:bg-[#2b303b]" do
      preview_component = "Previews::#{name.classify}".constantize.new
      render UI::Preview.new(heading: name) do |preview|
        preview.preview { render preview_component }
        preview.code { preview_component.to_code }
      end
    end
  end

  def render_affordance_previews(name, items: nil)
    items ||= Content::Data.const_get(name.classify.pluralize).all
    preview_class = "Previews::#{name.classify}".constantize

    safe_join(items.map do |item|
      content_tag :div, class: "prose-ul:p-0 prose-ul:m-0 prose-li:p-0 prose-li:m-0 prose-ul:leading-none prose-pre:my-0 prose-pre:bg-[#2b303b]" do
        attributes = {name: item.name, text: item.text, classes: item[:classes]}.compact
        preview_component = preview_class.new(**attributes)
        render UI::Preview.new(heading: item.name, variant: :affordance) do |preview|
          preview.preview { render preview_component }
          preview.code { preview_component.to_code }
        end
      end
    end)
  end
end
