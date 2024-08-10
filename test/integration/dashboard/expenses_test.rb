# frozen_string_literal: true

require "test_helper"

module Dashboard
  class ExpensesTest < ActionDispatch::IntegrationTest
    test "render json grouped expenses for dashboard chart" do
      account = create(:account, :with_expenses)
      category = account.categories.last
      subcategory = create(
        :subcategory,
        name: "mantenimiento",
        category:
      )
      create(:expense, subcategory:, category:, account:)
      category_feeding = create(:category, name: "alimentacion", account:)
      subcategory_pantry = create(:subcategory, name: "despensa", category: category_feeding)
      create(:expense, subcategory: subcategory_pantry, category: category_feeding, account:)

      login email: account.email, password: account.password
      get "/dashboard/expenses", as: :json

      assert_response :success
      assert_equal [
        {
          "name" => "alimentacion",
          "children" => [
            {
              "name" => "despensa",
              "value" => 100
            }
          ]
        },
        {
          "name" => "vivienda",
          "children" => [
            {
              "name" => "mantenimiento",
              "value" => 100
            },
            {
              "name" => "renta",
              "value" => 100
            }
          ]
        }
      ], response.parsed_body
    end

    private

    def login(email: "user@example.com", password: "secret")
      post "/login", as: :json, params: { email:, password: }
    end
  end
end
