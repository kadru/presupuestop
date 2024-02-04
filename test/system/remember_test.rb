# frozen_string_literal: true

require "application_system_test_case"

class Remember < ApplicationSystemTestCase
  test "user sets 'Forget Me' in remember setting" do
    account = create(:account)

    login email: account.email, password: "verysecretpassword"
    visit "/remember"
    choose "remember", option: "forget"
    click_on translate!("rodauth.remember_button")

    assert_text translate!("rodauth.remember_notice_flash")
  end
end
