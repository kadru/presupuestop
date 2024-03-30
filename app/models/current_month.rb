# frozen_string_literal: true

# Calculates the next month and previous month dates from the current month
# It also possible to override the current month passing a String with date format valid by
# ActiveRecord::Type::Date otherwise defaults to the current month
class CurrentMonth < SimpleDelegator
  def initialize(month)
    super(ActiveRecord::Type::Date.new.cast(month) || Date.current.beginning_of_month)
  end

  def next_month
    __getobj__ + 1.month
  end

  def prev_month
    __getobj__ - 1.month
  end
end
