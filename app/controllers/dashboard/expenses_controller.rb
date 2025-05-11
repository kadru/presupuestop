# frozen_string_literal: true

module Dashboard
  # Show calculation of expenses for dashboard page
  class ExpensesController < AuthenticatedController
    def amount_by_category
      render json: CategoryAmountResource.new(
        Category.expenses_by_month(
          account_id: current_account.id,
          month: CurrentMonth.new(params[:current_month])
        )
      ).serialize
    end

    def amount_by_subcategory
      render json: CategoryAmountResource.new(
        Subcategory.expenses_by_month(
          category_id: params[:id],
          account_id: current_account.id,
          month: CurrentMonth.new(params[:current_month])
        )
      ).serialize
    end
  end
end
