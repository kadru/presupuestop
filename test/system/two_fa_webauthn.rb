# frozen_string_literal: true

require "application_system_test_case"

class TwoFaWebauthn < ApplicationSystemTestCase
  test "should setup webauthn and remove remove webauthn" do
    account = create(:account)

    login email: account.email, password: account.password
    # Setup webauthn passkey
    visit "/webauthn-setup"
    fill_in :password, with: account.password
    click_on translate!("rodauth.webauthn_setup_button")

    assert_text translate!("rodauth.webauthn_setup_notice_flash")

    # Remove webauthn passkey
    visit "/multifactor-manage"
    click_on translate!("rodauth.webauthn_remove_link_text")
    fill_in :password, with: account.password
    choose option: account.webauthn_keys.last.webauthn_id
    click_on translate!("rodauth.webauthn_remove_button")

    assert_text translate!("rodauth.webauthn_remove_notice_flash")
  end
end
