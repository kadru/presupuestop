# frozen_string_literal: true

require "test_helper"

module Dashboard
  class ExpensesTest < ActionDispatch::IntegrationTest
    describe "GET /dashboard/expenses/amount_by_category" do
      it "renders json grouped expenses sum by category" do
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
        get "/dashboard/expenses/amount_by_category", as: :json

        assert_response :success
        assert_pattern do
          response.parsed_body => [
              {
                groupId: Integer,
                name: "vivienda",
                value: 20_000
              },
              {
                groupId: Integer,
                name: "alimentacion",
                value: 10_000
              }
            ]
        end
      end
    end

    describe "GET /dashboard/expenses/:id/amount_by_subcategory" do
      it "renders json grouped expenses sum by subcategory" do
        account = create(:account, :with_expenses)
        category = account.categories.last
        subcategory = create(
          :subcategory,
          name: "mantenimiento",
          category:
        )
        create(:expense, subcategory:, category:, account:)

        login email: account.email, password: account.password
        get "/dashboard/expenses/#{category.id}/amount_by_subcategory", as: :json

        assert_response :success
        assert_pattern do
          response.parsed_body => [
              {
                groupId: Integer,
                name: "renta",
                value: 10_000
              },
              {
                groupId: Integer,
                name: "mantenimiento",
                value: 10_000
              }
            ]
        end
      end
    end

    private

    def login(email: "user@example.com", password: "secret")
      post "/login", as: :json, params: { email:, password: }
    end
  end
end
