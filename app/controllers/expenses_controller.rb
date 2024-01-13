# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :set_spent, only: %i[ show edit update destroy ]

  # GET /expenses or /expenses.json
  def index
    @expenses = Expense.all
    render :index,
           locals: {
             expenses: Expense.ordered_with_category_subcategory,
             expense: Expense.new,
             categories: Category.for_select,
             subcategories: []
           }
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    render :new,
           locals: {
            expense: Expense.new,
            categories: Category.for_select,
            subcategories: []
           }
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    expense = Expense.new(spent_params)

    respond_to do |format|
      if expense.save
        format.html { redirect_to spents_path, notice: t(".successfully_created") }
        format.turbo_stream do
          render :create, locals: { expense: }
        end
      else
        format.html do
          render :new,
                 locals: {
                   expense:,
                   categories: Category.for_select,
                   subcategories: []
                 },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(spent_params)
        format.html { redirect_to spent_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    expense = Expense.find params[:id]
    expense.destroy

    respond_to do |format|
      format.html { redirect_to spents_url, notice: "Expense was successfully destroyed." }
      format.turbo_stream { render :destroy, locals: { expense: } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spent
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spent_params
      params
        .require(:expense)
        .permit(:name,
                :amount_unit,
                :category_id,
                :subcategory_id)
    end
end
