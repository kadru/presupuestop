# frozen_string_literal: true

# Application form builder to extend rails default form helpers with custom fields
class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def currency_field(method, options = {})
    data = options.fetch(:data) { options[:data] = {} }
    data[:controller] = "#{data[:controller] || ''} currency"
    text_field(
      method,
      options.merge(
        inputmode: "decimal"
      )
    )
  end
end
