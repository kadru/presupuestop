# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  describe "assocations" do
    should have_many(:subcategories)
    should have_many(:expenses).dependent(:nullify)
    should belong_to(:account)
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
