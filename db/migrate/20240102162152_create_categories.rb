class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.bigint :budget

      t.timestamps
    end
  end
end
