# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  should have_many(:expenses).dependent(:destroy)
  should have_many(:categories).dependent(:destroy)
  should define_enum_for(:status).with_values(unverified: 1, verified: 2, closed: 3)

  describe ".expenses_ordered_with_category_subcategory" do
    should "returns ordered expenses by id desc with included categories and subcategories" do
      account = create(:account, :with_expenses, expenses_count: 2)
      first_expense, last_expense = account.expenses_ordered_with_category_subcategory

      assert_equal 2, account.expenses_ordered_with_category_subcategory.size
      assert_operator first_expense.id, :>, last_expense.id
    end
  end

  describe "#categories#for_select" do
    should "returns categories to use for select options tag" do
      account = create(:account)
      category = create(:category, account:)

      assert_equal [[category.name,
                     category.id]], account.categories.for_select
    end
  end

  describe "#create_categories!" do
    should "create default categories and subcategories" do
      account = create(:account)

      account.create_categories!

      assert_equal 1, account.categories.size
      account.categories.each do |category|
        assert_equal 1, category.subcategories.size
      end
    end
  end
end
