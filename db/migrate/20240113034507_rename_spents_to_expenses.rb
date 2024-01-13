# frozen_string_literal: true

class RenameSpentsToExpenses < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    rename_table :spents, :expenses
  end
end
