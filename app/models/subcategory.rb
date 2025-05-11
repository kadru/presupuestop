# frozen_string_literal: true

# Stores subcategories to associosate with spents
class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :expenses, dependent: :nullify
  validates :name, presence: true
  validates :budget, numericality: { only_integer: true }

  def self.expenses_by_month(account_id:, category_id:, month:)
    joins(:category, :expenses)
      .merge(Category.by_category_account(account_id:, category_id:))
      .merge(Expense.by_month(month))
      .group("subcategories.id", "subcategories.name")
      .sum("expenses.amount")
  end
end
