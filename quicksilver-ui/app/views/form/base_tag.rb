# frozen_string_literal: true

class Form::BaseTag < UI::Base
  ALLOWED_OPTIONS = [:readonly, :disabled, :name, :autofocus, :data].freeze

  class << self
    def allowed_options
      ALLOWED_OPTIONS
    end
  end

  prop :form, AppFormBuilder, reader: :private
  prop :method, _Union(Symbol, String), reader: :private
  prop :value, _Any?, reader: :private
  prop :options, Hash, :**, reader: :private

  def id
    form.field_id(method)
  end

  def name
    form.field_name(method)
  end

  def value
    return @value if @value
    return if form.object.blank?
    return unless form.object.respond_to?(method)

    form.object.public_send(method)
  end

  private

  def options_with_defaults
    options.with_defaults(default_options)
  end

  def default_options
    {id:, name:, value:, data:}
  end
end
