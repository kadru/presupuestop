# frozen_string_literal: true

module Turnstile
  # View helpers to integrate with Cloudflare turnstile
  module ViewHelpers
    def turnstile_captcha
      tag.div class: "cf-turnstile", data: { sitekey: ENV.fetch("TURNSTILE_SITE_KEY") }
    end

    def turnstile_javascript_tag
      tag.script src: "https://challenges.cloudflare.com/turnstile/v0/api.js",
                 async: true,
                 defer: true
    end
  end
end
