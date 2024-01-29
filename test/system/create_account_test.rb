# frozen_string_literal: true

require "application_system_test_case"

class CreateAccount < ApplicationSystemTestCase
  test "create account" do
    visit "/create-account"
    fill_in "email", with: "user@example.com"
    fill_in "password", with: "averysecurepassword"
    fill_in "password-confirm", with: "averysecurepassword"
    click_on translate!("rodauth.create_account_button")

    assert_text translate!("rodauth.verify_account_email_sent_notice_flash")
  end

  test "create account with invalid email" do
    visit "/create-account"
    fill_in "email", with: "invalid@email"
    fill_in "password", with: "averysecurepassword"
    fill_in "password-confirm", with: "averysecurepassword"
    click_on translate!("rodauth.create_account_button")

    assert_text translate!("rodauth.create_account_error_flash")
  end
end
