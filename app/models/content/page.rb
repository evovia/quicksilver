class Content::Page < Perron::Resource
  delegate :title, :position, to: :metadata
end
