class Content::Form < Perron::Resource
  delegate :title, :description, :position, to: :metadata
end
