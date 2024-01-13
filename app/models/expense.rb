# frozen_string_literal: true

# Stores spents done with amount and categories
class Expense < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory

  scope :ordered_with_category_subcategory, lambda {
    order(id: :desc).includes(:category, :subcategory)
  }

  validates :name, presence: true, length: { maximum: 255 }
  validates :amount, presence: true, numericality: { only_integer: true }
  validates :amount_unit, presence: true, numericality: true
  validates :category_id, presence: true
  validates :subcategory_id, presence: true

  delegate :name,
           to: :category,
           prefix: true,
           allow_nil: true
  delegate :name,
           to: :subcategory,
           prefix: true,
           allow_nil: true

  attribute :amount_unit, :decimal

  def amount_unit=(value)
    super(value)
    amount_unit_ = attributes["amount_unit"]
    self.amount =  if amount_unit_.nil?
                     amount_unit_
                   else
                     (attributes["amount_unit"] * 100).to_i
                   end
  end

  def amount_unit
    return if amount.nil?

    quotient, remainder = amount.divmod 100
    BigDecimal("#{quotient}.#{remainder}")
  end
end
