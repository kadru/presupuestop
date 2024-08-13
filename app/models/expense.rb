# frozen_string_literal: true

# Stores spents done with amount and categories
class Expense < ApplicationRecord
  FACTOR = 100

  def self.total_amount_by_month_and_account(account_id:, date:)
    by_account(account_id).by_month(date).total_amount
  end

  def self.amount_grouped_by_cat_and_sub(account_id:, date:)
    joins(subcategory: :category)
      .by_account(account_id)
      .by_month(date)
      .group("categories.name",
             "subcategories.name")
      .total_amount
  end

  belongs_to :account
  belongs_to :category
  belongs_to :subcategory
  has_many :subcategories, through: :category, dependent: nil do
    def for_select
      pluck(:name, :id)
    end
  end

  scope :by_account, ->(account_id) { where(account_id:) }

  scope :with_category_subcategory, lambda {
    includes(:category, :subcategory)
  }

  scope :ordered, lambda {
    order(id: :desc)
  }

  scope :ordered_with_category_subcategory, lambda {
    order(id: :desc).includes(:category, :subcategory)
  }

  scope :by_month, lambda { |date|
    where(month: date.all_month)
  }

  scope :total_amount, -> { sum(:amount) }

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
    super
    amount_unit_ = attributes["amount_unit"]
    self.amount =  if amount_unit_.nil?
                     amount_unit_
                   else
                     (attributes["amount_unit"] * FACTOR).to_i
                   end
  end

  def amount_unit
    return if amount.nil?

    quotient, remainder = amount.divmod FACTOR
    BigDecimal("#{quotient}.#{remainder}")
  end

  delegate :blank?, to: :category, prefix: true
end
