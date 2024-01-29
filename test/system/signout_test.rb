# frozen_string_literal: true

require "application_system_test_case"

class SignoutTest < ApplicationSystemTestCase
  test "when user sign outs is redirected to login page" do
    account = create(:account)

    login(email: account.email, password: account.password)
    click_on "Logout"

    assert_text "Login"
  end
end
