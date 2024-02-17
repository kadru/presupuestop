# frozen_string_literal: true

require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:category)
    should belong_to(:subcategory)
    should belong_to(:account)
    should have_many(:subcategories).through(:category)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_most(255)

    should validate_presence_of(:amount)
    should validate_numericality_of(:amount).only_integer
  end

  describe "#amount_unit=" do
    should "write the given amount in cents" do
      expense = Expense.new
      expense.amount_unit = "1234.12"

      assert_in_delta 1234.12, expense.amount_unit
      assert_equal 123_412, expense.amount
    end

    context "when given value is nil" do
      should "write the given amount as nil" do
        expense = Expense.new
        expense.amount_unit = nil

        assert_nil expense.amount_unit
        assert_nil expense.amount
      end
    end
  end

  describe "#amount_unit" do
    should "return te amount in unit(froms cents to currency unit)" do
      expense = Expense.new amount: 200_000

      assert_in_delta BigDecimal("2000"), expense.amount_unit
    end

    context "when amount is nil" do
      should "returns nil" do
        expense = Expense.new amount: nil

        assert_nil expense.amount_unit
      end
    end
  end

  describe "#category_blank?" do
    should delegate_method(:blank?).to(:category).with_prefix
  end

  describe "#subcategories#for_select" do
    should "returns categories to use for select options tag" do
      account = create(:account)
      category = create(:category, account:)
      subcategory = category.subcategories.create! name: "renta"
      expense = create(:expense,
                       account:,
                       category:,
                       subcategory:)

      assert_equal [
        [subcategory.name,
         subcategory.id]
      ], expense.subcategories.for_select
    end
  end
end
