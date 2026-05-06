class AppFormBuilder < ActionView::Helpers::FormBuilder
  delegate :render, to: :@template

  def self.with_blank_error_proc(&block)
    old_error_proc = ActionView::Base.field_error_proc
    begin
      ActionView::Base.field_error_proc = proc do |tag, instance|
        tag
      end
      block.call
    ensure
      ActionView::Base.field_error_proc = old_error_proc
    end
  end

  def group(method, options = {})
    render Form::Group.new(form: self, method:, type: options[:type] || :text, **options.except(:type))
  end

  def text_field(method, options = {})
    render Form::TextField.new(form: self, method:, **options)
  end

  def label(method, text = nil, options = {}, &block)
    render Form::Label.new(form: self, method:, text:, **options)
  end

  def hint(method, text = nil, options = {}, &block)
    render Form::Hint.new(form: self, method:, text:, **options)
  end

  def error(method, text = nil, options = {}, &block)
    render Form::Error.new(form: self, method:, text:, **options)
  end

  def submit(value = nil, options = {})
    super(value, options.with_defaults(class: "ui-button ui-button-primary"))
  end
end
