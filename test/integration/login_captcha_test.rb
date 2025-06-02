# frozen_string_literal: true

require "test_helper"

class LoginCaptchaTest < ApplicationIntegrationTest
  describe "login" do
    setup do
      @account = create(:account)
    end

    context "when captcha validation pass" do
      it "it redirects to the home page with a success message" do
        stub_turnstile_site_verify
        login email: @account.email, password: @account.password, cf_turnstile_response: "XXXX.DUMMY.TOKEN.XXXX"

        assert_equal translate!("rodauth.login_notice_flash"), flash[:notice]
        assert_redirected_to "/"
      end
    end

    context "when captcha validation fails" do
      it "redirect to the login page with a failure message" do
        stub_turnstile_site_verify(response_body: { "success" => false,
                                                    "error-codes" => ["missing-input-response"],
                                                    "messages" => [] },
                                   request_response: nil)
        login email: @account.email, password: @account.password, cf_turnstile_response: nil

        assert_equal translate!("failed_captcha_message"), flash[:alert]
        assert_redirected_to "/login"
      end
    end
  end
end
