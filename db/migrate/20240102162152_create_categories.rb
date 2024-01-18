# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.1] # :nodoc:
  def change
    create_table :categories do |t|
      t.string :name
      t.bigint :budget

      t.timestamps
    end
  end
end
