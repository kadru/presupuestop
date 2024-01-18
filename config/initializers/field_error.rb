# frozen_string_literal: true

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  fragment = Nokogiri::HTML5.fragment(html_tag.to_s)
  if fragment.at_css "label"
    html_tag
  else
    html_tag + content_tag(
      :span,
      instance.error_message.join(" "),
      class: "pure-form-message-inline warning"
    )
  end
end
