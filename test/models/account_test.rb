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

  describe "#expenses_ordered_with_category_subcategory#by_month" do
    it "returns expenses filtered by given month" do
      account = create(:account)
      category = create(:category_with_subcategories, account:)
      expense_march = create(:expense,
                             month: Date.new(2024, 3, 1),
                             category:,
                             account:,
                             subcategory: category.subcategories.last)
      create(:expense,
             month: Date.new(2024, 2, 1),
             category:,
             account:,
             subcategory: category.subcategories.last)

      assert_equal [expense_march],
                   account
                     .expenses_ordered_with_category_subcategory
                     .by_month(Date.new(2024, 3, 1))
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

  describe "#total_amount_expenses_by_month" do
    it "returns the total amount expenses of the account by month" do
      account = build(:account, id: 0)
      given_date = Time.zone.local(2024, 1, 1)

      Expense.stub :total_amount_by_month_and_account,
                   lambda { |account_id:, date:|
                     assert_equal account.id, account_id
                     assert_equal date, given_date
                     1000
                   } do
        assert_equal 1000, account.total_amount_expenses_by_month(Time.zone.local(2024, 1, 1))
      end
    end
  end
end
