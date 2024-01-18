# frozen_string_literal: true

class CreateSpents < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    create_table :spents do |t|
      t.bigint :amount
      t.string :name
      t.references :category
      t.references :subcategory

      t.timestamps
    end
  end
end
