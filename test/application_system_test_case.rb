# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  def login(email: "user@example.com", password: "averysecret")
    visit "/login"
    fill_in "login", with: email
    fill_in "password", with: password
    click_on "Login"
  end
end
