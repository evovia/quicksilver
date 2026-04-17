class Content::Component < Perron::Resource
  delegate :name, :description, to: :metadata
end
