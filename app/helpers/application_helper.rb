module ApplicationHelper
  def implementation_of(name)
    File.read(Rails.root.join("app/views/ui/#{name}.rb")).html_safe
  end
end
