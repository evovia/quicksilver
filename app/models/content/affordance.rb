class Content::Affordance < Perron::Resource
  delegate :title, :description, to: :metadata
end
