# frozen_string_literal: true

require "application_system_test_case"

class ChangeEmailTest < ApplicationSystemTestCase
  def teardown
    ApplicationMailer.deliveries.clear
  end

  test "a user change email of his account" do
    account = create(:account)

    login email: account.email, password: account.password
    visit "/profile"
    click_on translate!("links.change_login")
    fill_in "email", with: "a-new-shiny-email@example.com"
    fill_in "password", with: account.password
    click_on translate!("rodauth.change_login_button")

    assert_text translate!("rodauth.change_login_needs_verification_notice_flash")

    visit email_link(%r{(/verify-login-change\?key=.+)$}, "a-new-shiny-email@example.com")
    click_on translate!("rodauth.verify_login_change_button")

    assert_text translate!("rodauth.verify_login_change_notice_flash")
  end
end
