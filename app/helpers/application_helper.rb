# frozen_string_literal: true

# Here group wide application helper for views
module ApplicationHelper
  def resource_title
    t("resource.title.#{controller.controller_name}")
  end

  def in_json(**keys)
    keys.to_json
  end
end
