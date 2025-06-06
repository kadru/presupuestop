# frozen_string_literal: true

require "application_system_test_case"

class CreateAccount < ApplicationSystemTestCase
  def teardown
    ApplicationMailer.deliveries.clear
  end

  test "create account" do
    stub_turnstile_site_verify(request_response: "")
    visit "/create-account"
    fill_in "email", with: "user@example.com"
    fill_in "password", with: "averysecurepassword"
    fill_in "password-confirm", with: "averysecurepassword"
    click_on translate!("rodauth.create_account_button")

    assert_text translate!("rodauth.verify_account_email_sent_notice_flash")
  end

  test "create account with invalid email" do
    stub_turnstile_site_verify(request_response: "")

    visit "/create-account"
    fill_in "email", with: "invalid@email"
    fill_in "password", with: "averysecurepassword"
    fill_in "password-confirm", with: "averysecurepassword"
    click_on translate!("rodauth.create_account_button")

    assert_text translate!("rodauth.create_account_error_flash")
  end
end
