class Form::Combobox::AsyncSearchResult < UI::Base
  prop :results, _Union(Array), reader: :private
  prop :text_method, _Union(String, Symbol, _Lambda), default: :name, reader: :private
  prop :value_method, _Union(String, Symbol), default: :to_param, reader: :private

  def view_template
    if results.any?
      results.each do |result|
        render Form::Combobox::Choice.new(choice: result, text_method:, value_method:)
      end
    else
      li(class: "tw:px-4 tw:py-2 tw:text-gray-500 tw:text-sm tw:italic") do
        "No results"
      end
    end
  end
end
