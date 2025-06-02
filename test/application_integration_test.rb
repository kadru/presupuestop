# frozen_string_literal: true

class ApplicationIntegrationTest < ActionDispatch::IntegrationTest
  def login(email:, password:, cf_turnstile_response: "XXXX.DUMMY.TOKEN.XXXX")
    post("/login",
         params: {
           email:,
           password:,
           "cf-turnstile-response": cf_turnstile_response
         },
         headers: {
           referer: "http://www.example.com/login"
         })
  end
end
