# frozen_string_literal: true

class AddAccountIdToCategories < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    add_reference(:categories, :account, foreign_key: true)
  end
end
