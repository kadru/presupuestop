# frozen_string_literal: true

require "application_system_test_case"

class SpentsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit spents_url

    assert_selector "h1", text: "Spents"
  end

  test "should create spent" do
    visit spents_url
    click_on "New Spent"

    fill_in "spent[name]", with: "cinema"
    fill_in "spent[amount]", with: 1111
    click_on "Create Spent"

    within "table" do
      assert_text "cinema"
      assert_text "1111"
    end
  end

  test "should update Spent" do
    skip
  end

  test "should destroy Spent" do
    skip
  end
end
