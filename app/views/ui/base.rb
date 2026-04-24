# frozen_string_literal: true

class UI::Base < Phlex::HTML
  TAILWIND_MERGER = ::TailwindMerge::Merger.new.freeze unless defined?(TAILWIND_MERGER)

  extend Literal::Properties
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::ClassNames

  register_output_helper :icon

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  prop :class, _Nilable(String)
  prop :data, Hash, default: {}.freeze, reader: :private

  private

  def classes
    TAILWIND_MERGER.merge [default_classes, @class].join(" ")
  end

  def default_classes
  end
end
