# frozen_string_literal: true

# Manage expenses
class ExpensesController < AuthenticatedController
  # GET /expenses
  def index
    current_month = CurrentMonth.new current_month_param
    render :index,
           locals: {
             expenses: current_account.expenses_ordered_with_category_subcategory.by_month(current_month),
             new_expense: Expense.new(month: current_month),
             categories: current_account.categories.for_select,
             subcategories: [],
             current_month:,
             prev_month: current_month.prev_month,
             next_month: current_month.next_month
           }
  end

  # GET /expenses/new
  def new
    render :new,
           locals: {
             expense: current_account.expenses.build,
             categories: current_account.categories.for_select,
             subcategories: []
           }
  end

  # GET /expenses/1/edit
  def edit
    expense = current_account.expenses.find params[:id]
    render :edit,
           locals: {
             expense:,
             categories: current_account.categories.for_select,
             subcategories: expense.subcategories.for_select
           }
  end

  # POST /expenses
  def create
    current_month = CurrentMonth.new current_month_param
    expense = current_account.expenses.build(expense_params)
    categories_for_select = current_account.categories.for_select

    respond_to do |format|
      if expense.save
        format.turbo_stream do
          render :create,
                 locals: {
                   expense:,
                   new_expense: Expense.new(month: current_month),
                   categories: categories_for_select,
                   subcategories: []
                 }
        end
      else
        format.html do
          render :new,
                 locals: {
                   expense:,
                   categories: categories_for_select,
                   subcategories: []
                 },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /expenses/1
  def update
    expense = current_account.expenses.find params[:id]
    if expense.update(expense_params)
      respond_to do |format|
        format.turbo_stream { render :update, locals: { expense: } }
      end
    else
      render :edit,
             locals: {
               expense:,
               categories: current_account.categories.for_select,
               subcategories: expense.subcategories.for_select
             },
             status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1
  def destroy
    expense = current_account.expenses.find params[:id]
    expense.destroy

    respond_to do |format|
      format.html { redirect_to spents_url, notice: t(".successfully_deleted") }
      format.turbo_stream { render :destroy, locals: { expense: } }
    end
  end

  private

  def expense_params
    params
      .require(:expense)
      .permit(:name,
              :amount_unit,
              :month,
              :category_id,
              :subcategory_id)
  end

  def current_month_param
    params[:current_month] || (params[:expense] && join_date_select_params(params[:expense]))
  end

  def join_date_select_params(parameter, field: "month")
    parameter.select { _1.start_with?(field) }.values.join("-")
  end
end
