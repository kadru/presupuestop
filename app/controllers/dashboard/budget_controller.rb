# frozen_string_literal: true

module Dashboard
  # Manages the budget dashboard
  class BudgetController < ApplicationController
    def show
      current_month = CurrentMonth.new(params[:current_month])
      render :show, locals: {
        current_month: current_month
      }
    end
  end
end
