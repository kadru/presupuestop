# frozen_string_literal: true

require "application_system_test_case"

class LoginPasswordTest < ApplicationSystemTestCase
  test "login" do
    account = create(:account)
    visit "/login"

    fill_in "email", with: account.email
    click_on translate!("rodauth.login_button")
    fill_in "password", with: "verysecretpassword"
    click_on translate!("rodauth.login_button")

    assert_text "You have been logged in"
  end
end
