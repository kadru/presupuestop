# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  def login(email: "user@example.com", password: "averysecret")
    visit "/login"
    fill_in "login", with: email
    click_on translate!("rodauth.login_button")
    fill_in "password", with: password
    click_on translate!("rodauth.login_button")
  end

  def logout
    click_on translate!("rodauth.logout_button")
  end

  def setup
    Capybara.app_host = "http://localhost"
    setup_virtual_auth
  end

  def setup_virtual_auth
    page.driver.browser.add_virtual_authenticator(
      Selenium::WebDriver::VirtualAuthenticatorOptions.new(
        user_verified: true, # These options support login authentication using webauthn
        user_verification: true
      )
    )
  end
end
