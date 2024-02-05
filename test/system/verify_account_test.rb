# frozen_string_literal: true

require "application_system_test_case"

class VerifyAccountTest < ApplicationSystemTestCase
  def teardown
    ApplicationMailer.deliveries.clear
  end

  test "login with a unveryfied account after grace period, " do
    account = create(:unverified_account, :expired_grace_period)

    visit "/login"
    fill_in "email", with: account.email
    fill_in "password", with: "verysecretpassword"
    click_on translate!("rodauth.login_button")

    assert_text translate!("rodauth.attempt_to_login_to_unverified_account_error_flash")
    assert_text translate!("rodauth.verify_account_resend_explanatory_text")

    click_on translate!("rodauth.verify_account_resend_button")
    visit email_link(%r{(/verify-account\?key=.+)$}, account.email)
    click_on translate!("rodauth.verify_account_button")

    assert_text translate!("rodauth.verify_account_notice_flash")
  end

  test "resend verify account" do
    account = create(:unverified_account, :expired_grace_period)

    visit "/login"
    click_on translate!("rodauth.verify_account_resend_link_text")
    fill_in "email", with: account.email
    click_on translate!("rodauth.verify_account_resend_button")

    assert_text translate!("rodauth.verify_account_email_sent_notice_flash")
  end
end
