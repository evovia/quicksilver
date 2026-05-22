# frozen_string_literal: true

class Form::PhoneField < Form::Input
  private

  def type = :tel
end
