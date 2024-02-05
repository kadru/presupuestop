# frozen_string_literal: true

require "application_system_test_case"

class ChangePasswordsTest < ApplicationSystemTestCase
  def teardown
    ApplicationMailer.deliveries.clear
  end

  test "user changes password" do
    account = create(:account)

    login email: account.email, password: account.password
    visit "/profile"
    click_on translate!("links.change_password")
    fill_in "password", with: account.password
    fill_in "new-password", with: "anewshinypassword"
    fill_in "password-confirm", with: "anewshinypassword"
    click_on translate!("rodauth.change_password_button")

    assert_text translate!("rodauth.change_password_notice_flash")

    email = ApplicationMailer.deliveries.last

    assert_equal email.subject, translate!("rodauth.password_changed_email_subject")
  end
end
