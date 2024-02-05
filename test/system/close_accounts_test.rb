# frozen_string_literal: true

require "application_system_test_case"

class CloseAccountsTest < ApplicationSystemTestCase
  test "a user closes it's account" do
    account = create(:account)

    login email: account.email, password: account.password
    visit "/profile"
    click_on translate!("links.close_account")
    fill_in "password", with: account.password
    click_on translate!("rodauth.close_account_button")

    assert_text translate!("rodauth.close_account_notice_flash")
  end
end
