# frozen_string_literal: true

# Here group wide application helper for views
module ApplicationHelper
  include Turnstile::ViewHelpers

  def resource_title
    t("resource.title.#{controller.controller_name}")
  end

  def in_json(**keys)
    keys.to_json
  end

  def flash_icon(flash_type)
    { "notice" => "info", "alert" => "warning", "error" => "error" }.fetch(flash_type.to_s, "info")
  end

  def flash_snackbar_type(flash_type)
    flash_type == "error" ? "error" : ""
  end
end
