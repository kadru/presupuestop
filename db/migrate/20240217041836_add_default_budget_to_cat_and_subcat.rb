# frozen_string_literal: true

class AddDefaultBudgetToCatAndSubcat < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    change_column_default :categories, :budget, from: nil, to: 0
    change_column_default :subcategories, :budget, from: nil, to: 0
  end
end
