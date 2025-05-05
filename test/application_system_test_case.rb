# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400] do |option|
    option.unhandled_prompt_behavior = :ignore
  end

  def self.driven_by_selenium_headful
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400] do |option|
      option.unhandled_prompt_behavior = :ignore
    end
  end

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
    Capybara.default_max_wait_time = 10
    Capybara::Lockstep.debug = ENV.fetch("CAPYBARA_LOCKSTEP_DEBUG", false)
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

  def create_expense
    category = create(:category_with_subcategories, account: @account)

    @account.expenses.create!(
      name: "renta departamento",
      amount: 10_000,
      category:,
      subcategory: category.subcategories.last
    )
  end
end
