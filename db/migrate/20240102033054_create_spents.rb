class CreateSpents < ActiveRecord::Migration[7.1]
  def change
    create_table :spents do |t|
      t.integer :amount
      t.string :name
      t.references :category
      t.references :subcategory
      t.timestamps
    end
  end
end
