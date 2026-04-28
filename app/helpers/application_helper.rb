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
end
