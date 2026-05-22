module AppFormHelper
  def app_form_with(*, **, &)
    AppFormBuilder.with_blank_error_proc do
      form_with(*, builder: AppFormBuilder, **, &)
    end
  end
end
