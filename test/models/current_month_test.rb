# frozen_string_literal: true

require "test_helper"

class CurrentMonthTest < ActiveSupport::TestCase
  describe "#next_month" do
    it "returns the next month date" do
      assert_equal Date.new(2025, 1, 1), CurrentMonth.new("2024-12-1").next_month
    end

    it "when a valid date is not given, it uses the current date" do
      travel_to Date.new(2024, 5, 1) do
        assert_equal Date.new(2024, 6, 1), CurrentMonth.new("invalid date").next_month
      end
    end
  end

  describe "#prev_month" do
    it "returns the previous month" do
      assert_equal Date.new(2023, 12, 1), CurrentMonth.new("2024-1-1").prev_month
    end
  end
end
