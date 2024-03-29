# frozen_string_literal: true

# Gives to spents a custom category to belong
class Category < ApplicationRecord
  belongs_to :account
  has_many :expenses, dependent: :nullify
  has_many :subcategories, dependent: :destroy

  scope :order_by_name, -> { order(:name) }

  validates :name, presence: true, length: { maximum: 255 }
  validates :budget, numericality: { only_integer: true }

  accepts_nested_attributes_for :subcategories,
                                allow_destroy: true,
                                reject_if: :all_blank
end
