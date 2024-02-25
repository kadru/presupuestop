# frozen_string_literal: true

require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  def setup
    @account = create(:account)
    login email: @account.email, password: @account.password
  end

  test "visiting the categories index" do
    @account.create_categories!
    visit categories_path

    assert_selector "header > h2", text: "CATEGORIES"
    # assert categories and budget
    assert_text "vivienda"
    assert_text "budget: $0.00"
  end

  test "should add a create a category" do
    visit categories_path
    click_on "add category"
    fill_in "category[name]", with: "a category name"
    click_on "add subcategory"
    within "#subcategory_0" do
      fill_in "name", with: "a sub name"
      fill_in "budget", with: 1_000
    end
    click_on translate!("helpers.submit.category.create")

    assert_text translate!("categories.created")
    assert_text "a category name"
    assert_text "budget: $1,000.00"
  end

  test "should destroy a category" do
    @account.create_categories!
    category = @account.categories.last
    visit categories_path
    within "#category_#{category.id}" do
      click_on translate!("categories.category.delete")
    end

    assert_no_css "#category_#{category.id}"
  end
end
