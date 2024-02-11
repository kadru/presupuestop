# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  should have_many(:expenses).dependent(:destroy)
  should define_enum_for(:status).with_values(unverified: 1, verified: 2, closed: 3)

  describe ".expenses_ordered_with_category_subcategory" do
    should "returns ordered expenses by id desc with included categories and subcategories" do
      account = create(:account, :with_expenses, expenses_count: 2)
      first_expense, last_expense = account.expenses_ordered_with_category_subcategory

      assert_equal 2, account.expenses_ordered_with_category_subcategory.size
      assert_operator first_expense.id, :>, last_expense.id
    end
  end
end
