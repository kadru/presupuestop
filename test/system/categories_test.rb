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

  test "should create a category" do
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

  test "when subcategory has missing name should show error message" do
    visit new_category_path
    fill_in "category[name]", with: "a category name"
    click_on translate!("categories.add_subcategory.new_subcategory")
    click_on translate!("helpers.submit.category.create")

    assert_text translate!("errors.messages.blank")
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

  test "should update a category" do
    create(:category_with_subcategories, :budget1000, account: @account)
    category = @account.categories.last

    visit edit_category_path(category)

    assert_field "category[budget]", with: "1000"

    # remove subcategory
    within "#subcategory_0" do
      click_on translate!("subcategories.form.remove_submit")
    end

    assert_field "category[budget]", with: "0"

    click_on translate!("helpers.submit.category.update")

    assert_text translate!("categories.updated")
  end

  test "when updating a category with invalid name should show an error message" do
    create(:category, account: @account)
    category = @account.categories.last

    visit edit_category_path(category)
    fill_in "category[name]", with: ""
    click_on translate!("helpers.submit.category.update")

    assert_text translate!("errors.messages.blank")
  end
end
