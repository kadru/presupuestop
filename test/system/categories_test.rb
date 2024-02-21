# frozen_string_literal: true

require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  driven_by :selenium, using: :chrome

  def setup
    @account = create(:account)
    @account.create_categories!
    login email: @account.email, password: @account.password
  end

  test "visiting the categories index" do
    visit categories_path

    assert_selector "header > h2", text: "CATEGORIES"
    # assert categories and budget
    assert_text "vivienda"
    assert_text "budget: 0"
  end

  test "should destroy a category" do
    category = @account.categories.last
    visit categories_path
    within "#category_#{category.id}" do
      click_button translate!("categories.category.delete")
    end

    assert_no_css "#category_#{category.id}"
  end
end
