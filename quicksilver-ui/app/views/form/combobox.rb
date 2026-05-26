# frozen_string_literal: true

class Form::Combobox < Form::BaseTag
  ALLOWED_OPTIONS = [
    :choices,
    :text_method,
    :value_method,
    :multiple,
    :selected,
    :help_text,
    :searching_text,
    :no_results_text,
    :all_choices_selected_text
  ].freeze

  class << self
    def allowed_options
      super + ALLOWED_OPTIONS
    end
  end

  prop :choices, _Union(Array, String), reader: :private
  prop :text_method, _Union(String, Symbol), default: :name, reader: :private
  prop :value_method, _Union(String, Symbol), default: :to_param, reader: :private
  prop :multiple, _Boolean?, default: false, reader: :private
  prop :selected, _Any?, predicate: :private, reader: :private
  prop :help_text, _String?, default: -> { "Start typing to search" }, reader: :private
  prop :searching_text, _String?, default: -> { "Searching" }, reader: :private
  prop :no_results_text, _String?, default: -> { "No results" }, reader: :private
  prop :all_choices_selected_text, _String?, default: -> { "All choices selected" }, reader: :private

  def view_template
    div data: {
      controller: "combobox",
      combobox_multiple_value: multiple,
      combobox_search_url_value: choices.is_a?(String) ? choices : nil,
      combobox_help_text_value: help_text,
      combobox_searching_text_value: searching_text,
      combobox_no_results_text_value: no_results_text,
      combobox_all_choices_selected_text_value: all_choices_selected_text,
      combobox_input_name_value: name,
      has_choices: multiple && existing_selections.any?
    }, class: "relative group" do
      fieldset(class: classes, data:) do
        input(
          id: input_id,
          type: :search,
          role: "combobox",
          "aria-expanded": "false",
          "aria-autocomplete": "list",
          "aria-haspopup": "listbox",
          data: {
            combobox_target: "input",
            action: "keydown->combobox#keydown input->combobox#search focus->combobox#showMenu blur->combobox#hideMenuWithDelay"
          },
          value: input_value,
          class: input_classes,
          placeholder: options[:placeholder] || ""
        )

        render_selected
      end

      div data: {
        combobox_target: "menu",
        transition_enter_from: "opacity-0 scale-95",
        transition_enter_to: "opacity-100 scale-100",
        transition_leave_from: "opacity-100 scale-100",
        transition_leave_to: "opacity-0 scale-95"
      }, class: "hidden w-full transition transform origin-top-left absolute left-0 top-0 z-50" do
        menu role: "listbox", class: "w-full bg-white rounded-lg shadow-lg outline -outline-offset-1
        outline-gray-300 inline-flex flex-col justify-start items-start overflow-hidden max-h-60 overflow-y-auto" do
          render_choices_container
        end
      end
    end
  end

  private

  def default_classes
    "flex flex-col-reverse overflow-hidden relative rounded outline outline-gray-400 bg-white hover:outline-gray-900 focus-within:outline-gray-900 has-disabled:hover:outline-gray-400 focus-within:outline-2 data-invalid:outline-red-600 data-invalid:focus-within:outline-gray-900 data-invalid:hover:outline-gray-900"
  end

  def input_id = @input_id ||= "#{name}_#{Random.uuid}"

  def default_options
    {id:, name:, data: {controller: "combobox"}}
  end

  def render_selected
    if multiple?
      render_selected_items_container
      render_tag_template
    else
      input(type: "hidden", name:, data: {combobox_target: "hiddenInput"}, value: selected&.public_send(value_method))
    end
  end

  def render_selected_items_container
    div(
      data: {combobox_target: "selectedItemsContainer"},
      class: selected_items_classes
    ) do
      selected&.each do |item|
        render Form::Combobox::SelectedItem.new(form:, method:, item:)
      end
    end
  end

  def render_tag_template
    template(
      data: {combobox_target: "tagTemplate"}
    ) do
      render UI::Tag.new(text: "", size: :sm)
    end
  end

  def input_classes
    class_names(
      "peer border-0 group-data-[combobox-busy-value=true]:animate-pulse"
    )
  end

  def existing_selections
    existing_values = if selected?
      selected
    elsif form&.object&.respond_to?(method)
      form.object.public_send(method)
    else
      return []
    end

    values = Array(existing_values)

    values = [values.first] if single?

    values.compact.map do |value|
      {
        value: value.public_send(value_method),
        displayValue: value.public_send(text_method)
      }
    end
  end

  def input_value
    return unless single?
    return unless existing_selections.any?

    existing_selections.first[:displayValue]
  end

  def single?
    !multiple
  end

  def render_choices_container
    div(
      data: {combobox_target: "choicesContainer"},
      class: "w-full"
    ) do
      render_messages
      if choices_is_a_url?
        turbo_frame_tag turbo_frame_id, data: {combobox_target: "turboFrame"}, class: "w-full"
      else
        choices.each do |choice|
          render Form::Combobox::Choice.new(choice:, text_method:)
        end
      end
    end
  end

  def choices_is_a_url?
    choices.is_a? String
  end

  def render_messages
    div(data: {combobox_target: "helpText"},
      class: "hidden px-4 py-2 text-gray-500 text-sm italic") { help_text }

    div(data: {combobox_target: "noResults"},
      class: "hidden px-4 py-2 text-gray-500 text-sm italic") { no_results_text }

    div(data: {combobox_target: "searching"},
      class: "hidden px-4 py-2 text-gray-500 text-sm italic animate-pulse") { searching_text }

    div(data: {combobox_target: "allChoicesSelected"},
      class: "hidden px-4 py-2 text-gray-500 text-sm italic") { all_choices_selected_text }
  end

  def selected_items_classes
    class_names(
      "peer/selected-items flex flex-wrap gap-1 p-1 bg-gray-100 border-b border-gray-200 empty:hidden"
    )
  end

  def name
    multiple? ? "#{super}[]" : super
  end

  def turbo_frame_id
    "combobox_choices_#{input_id}".parameterize
  end

  def multiple?
    multiple
  end

  def errors
    return [] unless error?

    form.object.errors.where(method).map(&:full_message)
  end
end
