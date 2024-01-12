# frozen_string_literal: true

require "test_helper"

class SpentTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:category)
    should belong_to(:subcategory)
  end

  context "validations" do
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_most(255)

    should validate_presence_of(:amount)
    should validate_numericality_of(:amount).only_integer
  end

  describe "#amount_unit=" do
    should "write the given amount in cents" do
      spent = Spent.new
      spent.amount_unit = "1234.12"

      assert_in_delta 1234.12, spent.amount_unit
      assert_equal 123_412, spent.amount
    end

    context "when given value is nil" do
      should "write the given amount as nil" do
        spent = Spent.new
        spent.amount_unit = nil

        assert_nil spent.amount_unit
        assert_nil spent.amount
      end
    end
  end

  describe "#amount_unit" do
    should "return te amount in unit(froms cents to currency unit)" do
      spent = Spent.new amount: 200_000

      assert_in_delta BigDecimal("2000"), spent.amount_unit
    end

    context "when amount is nil" do
      should "returns nil" do
        spent = Spent.new amount: nil

        assert_nil spent.amount_unit
      end
    end
  end
end
