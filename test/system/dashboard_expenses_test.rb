# frozen_string_literal: true

require "application_system_test_case"

class DashboardExpensesTest < ApplicationSystemTestCase
  def setup
    @account = create(:account)

    login email: @account.email, password: @account.password
  end

  test "visiting the dashboard shows a default message for empty expenses data" do
    visit dashboard_path

    within(".chart") do
      assert_text translate!("dashboard.index.empty_expenses_data")
    end
  end

  test "visiting the dashboard with expenses to show a chart" do
    create_expense
    visit dashboard_path

    within(".chart") do
      assert_css "canvas"
    end
  end
end
