# frozen_string_literal: true

require "application_system_test_case"

class ResetPasswordsTest < ApplicationSystemTestCase
  def teardown
    ApplicationMailer.deliveries.clear
  end

  test "user requests a password reset" do
    account = create(:account)

    visit "/reset-password-request"

    assert_text translate!("rodauth.reset_password_explanatory_text")

    fill_in "email", with: account.email
    click_on translate!("rodauth.reset_password_request_button")

    assert_text translate!("rodauth.reset_password_email_sent_notice_flash")

    visit email_link(%r{(/reset-password\?key=.+)$}, account.email)
    fill_in "password", with: "anewsecurepassword"
    fill_in "password-confirm", with: "anewsecurepassword"
    click_on translate!("rodauth.reset_password_button")

    assert_text translate!("rodauth.reset_password_notice_flash")

    fill_in "email", with: account.email
    click_on translate!("rodauth.login_button")
    fill_in "password", with: "anewsecurepassword"
    click_on translate!("rodauth.login_button")

    assert_text translate!("rodauth.login_notice_flash")
  end

  test "user requests a password reset recently" do
    account = create(:account, :recently_password_reset)

    visit "/reset-password-request"

    assert_text translate!("rodauth.reset_password_explanatory_text")

    fill_in "email", with: account.email
    click_on translate!("rodauth.reset_password_request_button")

    assert_text translate!("rodauth.reset_password_email_recently_sent_error_flash")
  end
end
