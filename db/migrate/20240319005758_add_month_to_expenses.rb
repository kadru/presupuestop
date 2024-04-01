# frozen_string_literal: true

class AddMonthToExpenses < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    add_column :expenses, :month, :date, default: -> { "CURRENT_DATE" }, null: false
  end
end
