# frozen_string_literal: true

class CreateSubcategories < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    create_table :subcategories do |t|
      t.string :name
      t.bigint :budget
      t.references :category

      t.timestamps
    end
  end
end
