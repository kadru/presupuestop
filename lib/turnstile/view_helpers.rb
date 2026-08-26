# frozen_string_literal: true

module Turnstile
  # View helpers to integrate with Cloudflare turnstile
  module ViewHelpers
    def turnstile_captcha
      tag.div class: "turnstile-wrapper" do
        concat(tag.div(class: "cf-turnstile",
                data: {
                  sitekey: ENV.fetch("TURNSTILE_SITE_KEY"),
                  callback: "onTurnstileSuccess"
                }))
        concat(javascript_tag(nonce: true) do
          <<~JAVASCRIPT.html_safe
            function onTurnstileSuccess(token) {
              const event = "turnstile:success";
              const turnstileWrappers = document.getElementsByClassName("turnstile-wrapper");
              for (const wrapper of turnstileWrappers) {
                wrapper.dispatchEvent(
                  new Event(
                    event,
                    {
                      bubbles: true
                    }
                  )
                );
               }
            }
          JAVASCRIPT
        end)
      end
    end

    def turnstile_javascript_tag
      tag.script src: "https://challenges.cloudflare.com/turnstile/v0/api.js",
                 async: true,
                 defer: true
    end
  end
end
