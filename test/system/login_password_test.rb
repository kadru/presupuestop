# frozen_string_literal: true

require "application_system_test_case"

class LoginPasswordTest < ApplicationSystemTestCase
  test "login" do
    account = create(:account)
    visit "/login"

    fill_in "email", with: account.email
    fill_in "password", with: "verysecretpassword"
    click_on "Login"

    assert_text "You have been logged in"
  end
end
