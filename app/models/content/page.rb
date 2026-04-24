class Content::Page < Perron::Resource
  delegate :title, to: :metadata
end
