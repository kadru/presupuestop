# frozen_string_literal: true

require "test_helper"

class LoginCaptchaTest < ApplicationIntegrationTest
  describe "login" do
    setup do
      @account = create(:unverified_account, :expired_grace_period)
    end

    context "when captcha validation pass" do
      it "it redirects to the login page with a success message" do
        stub_turnstile_site_verify
        post "/verify-account-resend",
             params: { email: @account.email,
                       "cf-turnstile-response": "XXXX.DUMMY.TOKEN.XXXX" }

        assert_equal translate!("rodauth.verify_account_email_sent_notice_flash"), flash[:notice]
        assert_redirected_to "/login"
      end
    end

    context "when captcha validation fails" do
      it "redirect to the verify account page with a failure message" do
        stub_turnstile_site_verify(response_body: { "success" => false,
                                                    "error-codes" => ["missing-input-response"],
                                                    "messages" => [] },
                                   request_response: nil)
        post "/verify-account-resend",
             params: { email: @account.email,
                       "cf-turnstile-response": nil },
             headers: {
               referer: "http://www.example.com/verify-account-resend"
             }

        assert_equal translate!("failed_captcha_message"), flash[:alert]
        assert_redirected_to "/verify-account-resend"
      end
    end
  end
end
