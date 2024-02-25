# frozen_string_literal: true

require "application_system_test_case"

class SpentsTest < ApplicationSystemTestCase
  def setup
    @account = create(:account)
    login email: @account.email, password: @account.password
  end

  test "visiting the index" do
    create_expense
    visit expenses_url

    assert_selector "h2", text: "EXPENSE"
    within "table" do
      # Assert headers
      assert_text "name"
      assert_text "amount"
      assert_text "category"
      assert_text "subcategory"

      # assert rows
      assert_text "renta departamento"
      assert_text "$100.00"
      assert_text "vivienda"
      assert_text "renta"
    end
  end

  test "should create expense" do
    create(:category_with_subcategories, account: @account)

    visit expenses_url
    click_on "new expense"

    fill_in "expense[name]", with: "cinema"
    fill_in "expense[amount_unit]", with: 1111
    select "vivienda", from: "expense[category_id]"
    select "renta", from: "expense[subcategory_id]"
    click_on "add expense"

    within "table" do
      assert_text "cinema"
      assert_text "$1,111.00"
      assert_text "vivienda"
      assert_text "renta"
    end

    # should render a empty form after create a expense
    click_on "new expense"
    within "#popoverNew" do
      assert_field "expense[name]", with: ""
      assert_field "expense[amount_unit]", with: ""
      assert_field "expense[category_id]", with: ""
      assert_field "expense[subcategory_id]", with: ""
    end
  end

  test "when creating with empty data then should show a error message" do
    category = @account.categories.create! name: "vivienda"
    category.subcategories.create! name: "renta", category_id: category.id

    visit expenses_url
    click_on "new expense"
    click_on "add expense"

    assert_text("can't be blank")
  end

  test "should update Expense" do
    expense = create_expense

    visit expenses_url
    within "tr#expense_#{expense.id}" do
      click_on "edit"
    end

    fill_in "expense[name]", with: "renta"
    fill_in "expense[amount_unit]", with: 20_000
    select "vivienda", from: "expense[category_id]"
    select "renta", from: "expense[subcategory_id]"
    click_on "update expense"

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
      click_on "edit"
    end

    fill_in "expense[name]", with: ""
    click_on "update expense"

    assert_text "can't be blank"
  end

  test "should destroy Expense" do
    expense = create_expense

    visit expenses_url

    within "tr#expense_#{expense.id}" do
      click_on "delete"
    end

    assert_no_css "#spent_#{expense.id}"
  end

  private

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
