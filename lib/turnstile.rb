# frozen_string_literal: true

# Module that handles request to Cloudflare Turnstile Siteverify API
module Turnstile
  autoload :ViewHelpers, "turnstile/view_helper"

  URL = "https://challenges.cloudflare.com/turnstile/v0/siteverify"
  private_constant :URL

  def siteverify(token)
    response = HTTPX.post(
      URL,
      json: {
        secret: ENV.fetch("TURNSTILE_SECRET_KEY"),
        response: token
      }
    )
    return true if response.status < 300 && response.json["success"] == true

    false
  end
  module_function :siteverify
end
