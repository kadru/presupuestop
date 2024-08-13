# frozen_string_literal: true

module Dashboard
  class ExpensesController < AuthenticatedController
    def index
      render json: to_category_with_children(
        Expense.amount_grouped_by_cat_and_sub(
          account_id: current_account.id,
          date: CurrentMonth.new(params[:current_month])
        )
      )
    end

    private

    # transforms the total_amount hash to an array that the chart library can
    # understand, this is a divergent change consider to move a appropiate object
    def to_category_with_children(total_amount)
      total_amount.each_with_object({}) do |(key, value), acc|
        categroy, subcategory = key
        acc[categroy] ||= { name: categroy, children: [] }
        acc[categroy][:children] << { name: subcategory, value: value / Expense::FACTOR }
      end.values
    end
  end
end
