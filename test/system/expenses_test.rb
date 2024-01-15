# frozen_string_literal: true

require "application_system_test_case"

class SpentsTest < ApplicationSystemTestCase
  test "visiting the index" do
    create_expense
    visit expenses_url

    assert_selector "h2", text: "EXPENSE"
    within "table" do
      # Assert headers
      assert_text "Name"
      assert_text "Amount"
      assert_text "Category"
      assert_text "Subcategory"

      # assert rows
      assert_text "renta departamento"
      assert_text "$100.00"
      assert_text "vivienda"
      assert_text "renta"
    end
  end

  test "should create expense" do
    create(:category_with_subcategories)

    visit expenses_url
    click_on "New Expense"

    fill_in "expense[name]", with: "cinema"
    fill_in "expense[amount_unit]", with: 1111
    select "vivienda", from: "expense[category_id]"
    select "renta", from: "expense[subcategory_id]"
    click_on "Create Expense"

    within "table" do
      assert_text "cinema"
      assert_text "$1,111.00"
      assert_text "vivienda"
      assert_text "renta"
    end
  end

  test "when creating with empty data then should show a error message" do
    category = Category.create! name: "vivienda"
    Subcategory.create! name: "renta", category_id: category.id

    visit expenses_url
    click_on "New Expense"
    click_on "Create Expense"

    assert_text("can't be blank")
  end

  test "should update Expense" do
    expense = create_expense

    visit expenses_url
    within "tr#expense_#{expense.id}" do
      click_button "edit"
    end

    fill_in "expense[name]", with: "renta"
    fill_in "expense[amount_unit]", with: 20_000
    select "vivienda", from: "expense[category_id]"
    select "renta", from: "expense[subcategory_id]"
    click_on "Update Expense"

    within "table" do
      assert_text "renta"
      assert_text "$20,000.00"
      assert_text "vivienda"
      assert_text "renta"
    end
  end

  test "when updating with empty data then should show a error message" do
    expense = create_expense

    visit expenses_url
    within "tr#expense_#{expense.id}" do
      click_button "edit"
    end

    fill_in "expense[name]", with: ""
    click_on "Update Expense"

    assert_text "can't be blank"
  end

  test "should destroy Expense" do
    expense = create_expense

    visit expenses_url

    within "tr#expense_#{expense.id}" do
      click_button "delete"
    end

    assert_no_css "#spent_#{expense.id}"
  end

  private

  def create_expense
    category = create(:category_with_subcategories)

    create(:expense, category:, subcategory: category.subcategories.last)
  end
end