# frozen_string_literal: true

class Form::DateField < Form::Input
  def value
    super&.to_date&.iso8601
  end

  private

  def type = :date
end
