# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  describe "assocations" do
    should have_many(:subcategories)
    should belong_to(:account)
  end

  describe ".for_select" do
    should "returns an array of categories name and id" do
      category = create(:category)

      assert_equal [
        [
          category.name,
          category.id
        ]
      ], Category.for_select
    end
  end
end
