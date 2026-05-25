class DummyUser
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :email, :string

  class << self
    def all
      [
        new(name: "Donatello", email: "donnie@tmnt.com"),
        new(name: "Michelangelo", email: "michael@tmnt.com"),
        new(name: "Raphael", email: "raph@tmnt.com"),
        new(name: "Leonardo", email: "leo@tmnt.com"),
        new(name: "Shredder", email: "shred_it@footclan.com")
      ]
    end

    def first
      all.first
    end
  end

  def to_param
    name
  end
end
