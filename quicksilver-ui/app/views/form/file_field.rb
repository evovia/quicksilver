# frozen_string_literal: true

class Form::FileField < Form::Input
  private

  def type = :file

  def default_classes
    "text-sm text-gray-900
    file:mr-4 file:max-w-fit file:px-2 file:py-1 file:no-underline file:text-sm file:font-medium file:text-gray-950 file:border file:border-gray-900 file:hover:bg-gray-900 file:hover:text-white file:focus-visible:outline-2 file:focus-visible:outline-offset-2 file:focus-visible:outline-gray-900"
  end
end
