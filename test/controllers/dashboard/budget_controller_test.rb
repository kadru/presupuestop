# frozen_string_literal: true

require "test_helper"

module Dashboard
  class BudgetControllerTest < ActionDispatch::IntegrationTest
    test "should get show" do
      get dashboard_budget_show_url

      assert_response :success
    end
  end
end
