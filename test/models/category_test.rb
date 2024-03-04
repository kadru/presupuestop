# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  describe "assocations" do
    should have_many(:subcategories)
    should have_many(:expenses).dependent(:nullify)
    should belong_to(:account)
  end

  describe "validations" do
    it validate_presence_of(:name)
    it validate_length_of(:name).is_at_most(255)

    it validate_numericality_of(:budget).only_integer
  end

  should accept_nested_attributes_for(:subcategories).allow_destroy(true)

  describe ".order_by_name" do
    it "should return categories ordere by name" do
      account = create(:account)
      category_aba = create(:category, account:, name: "aba")
      category_zorg = create(:category, account:, name: "Zorg")

      assert_equal Category.order_by_name, [category_aba, category_zorg]
    end
  end

  describe "#destroy" do
    it "should nullify expenses owned by category destroyed" do
      account = create(:account)
      category = create(:category_with_subcategories, account:)
      expense = create(:expense, account:, category:, subcategory: category.subcategories.last)

      category.destroy

      assert_nil expense.reload.category_id
    end
  end
end
