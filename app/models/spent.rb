# frozen_string_literal: true

# Stores spents done with amount and categories
class Spent < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :subcategory, optional: true

  delegate :name,
           to: :category,
           prefix: true,
           allow_nil: true
  delegate :name,
           to: :subcategory,
           prefix: true,
           allow_nil: true
end
