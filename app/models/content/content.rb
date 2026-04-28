class Content::Content < Perron::Resource
  delegate :title, :description, to: :metadata
end
