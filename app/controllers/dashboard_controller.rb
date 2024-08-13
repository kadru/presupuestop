# frozen_string_literal: true

# Shows dashboard data
class DashboardController < AuthenticatedController
  def index
    current_month = CurrentMonth.new current_month_param
    render :index,
           locals: {
             current_month:,
             prev_month: current_month.prev_month,
             next_month: current_month.next_month
           }
  end

  private

  def current_month_param
    params[:current_month]
  end
end
