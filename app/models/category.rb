# frozen_string_literal: true

# Gives to spents a custom category to belong
class Category < ApplicationRecord
  belongs_to :account
  has_many :expenses, dependent: :nullify
  has_many :subcategories, dependent: :destroy

  scope :order_by_name, -> { order(:name) }
  scope :by_account, ->(account_id) { where(account_id:) }
  scope :by_category_account, ->(category_id:, account_id:) { where(id: category_id).by_account(account_id) }

  validates :name, presence: true, length: { maximum: 255 }
  validates :budget, numericality: { only_integer: true }

  def self.expenses_by_month(account_id:, month:)
    joins(subcategories: :expenses)
      .by_account(account_id)
      .merge(Expense.by_month(month))
      .group("categories.id", "categories.name")
      .sum("expenses.amount")
  end

  accepts_nested_attributes_for :subcategories,
                                allow_destroy: true,
                                reject_if: :all_blank
end
