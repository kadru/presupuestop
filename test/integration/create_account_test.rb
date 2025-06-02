# frozen_string_literal: true

require "test_helper"

class CreateAccountTest < ApplicationIntegrationTest
  describe "create account" do
    context "when captcha validation pass" do
      it "it redirects to the home page with a success message" do
        stub_turnstile_site_verify

        post "/create-account",
             params: { email: "some-very-nice-email@example.com",
                       password: "verysecret",
                       "password-confirm": "verysecret",
                       "cf-turnstile-response": "XXXX.DUMMY.TOKEN.XXXX" }

        assert_equal translate!("rodauth.verify_account_email_sent_notice_flash"), flash[:notice]
        assert_redirected_to "/"
      end
    end

    context "when captcha validation fails" do
      it "redirect to the login page with a failure message" do
        stub_turnstile_site_verify(response_body: { "success" => false,
                                                    "error-codes" => ["missing-input-response"],
                                                    "messages" => [] },
                                   request_response: nil)
        post "/create-account",
             params: { email: "some-very-nice-email@example.com",
                       password: "verysecret",
                       "password-confirm": "verysecret",
                       "cf-turnstile-response": nil },
             headers: {
               referer: "http://www.example.com/create-account"
             }

        assert_equal translate!("failed_captcha_message"), flash[:alert]
        assert_redirected_to "/create-account"
      end
    end
  end
end
