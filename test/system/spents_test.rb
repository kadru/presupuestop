# frozen_string_literal: true

require "application_system_test_case"

class SpentsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit spents_url

    assert_selector "h1", text: "Spents"
  end

  test "should create spent" do
    category = Category.create! name: "vivienda"
    Subcategory.create! name: "renta", category_id: category.id

    visit spents_url
    click_on "New Spent"

    fill_in "spent[name]", with: "cinema"
    fill_in "spent[amount_unit]", with: 1111
    select "vivienda", from: "spent[category_id]"
    select "renta", from: "spent[subcategory_id]"
    click_on "Create Spent"

    within "table" do
      assert_text "cinema"
      assert_text "$1,111.00"
      assert_text "vivienda"
      assert_text "renta"
    end
  end

  test "when updating empty data then should show a error message" do
    category = Category.create! name: "vivienda"
    Subcategory.create! name: "renta", category_id: category.id

    visit spents_url
    click_on "New Spent"
    click_on "Create Spent"

    assert_text("Validation failed")
  end

  test "should update Spent" do
    skip "not implemented yet"
  end

  test "should destroy Spent" do
    skip "not implemented yet"
  end
end
