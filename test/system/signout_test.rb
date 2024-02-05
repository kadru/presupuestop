# frozen_string_literal: true

require "application_system_test_case"

class SignoutTest < ApplicationSystemTestCase
  test "when user sign outs is redirected to login page" do
    account = create(:account)

    login(email: account.email, password: account.password)
    click_on translate!("rodauth.logout_button")

    assert_text translate!("rodauth.login_page_title")
  end

  test "when user signsout through signt out page" do
    account = create(:account)

    login email: account.email, password: account.password
    visit "/logout"
    click_on translate!("rodauth.logout_button")

    assert_text translate!("rodauth.login_page_title")
  end
end
