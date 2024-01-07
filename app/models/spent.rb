# frozen_string_literal: true

# Stores spents done with amount and categories
class Spent < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory

  validates :name, presence: true, length: { maximum: 255 }
  validates :amount, presence: true, numericality: { only_integer: true }

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
    self.amount = (attributes["amount_unit"] * 100).to_i
  end

  def amount_unit
    return BigDecimal("0") if amount.nil?

    quotient, remainder = amount.divmod 100
    BigDecimal("#{quotient}.#{remainder}")
  end
end
