# frozen_string_literal: true

# Stores subcategories to associosate with spents
class Subcategory < ApplicationRecord
  validates :name, presence: true
  validates :budget, numericality: { only_integer: true }
end
