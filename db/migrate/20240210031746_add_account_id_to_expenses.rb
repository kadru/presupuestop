# frozen_string_literal: true

class AddAccountIdToExpenses < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    add_reference :expenses, :account
  end
end
