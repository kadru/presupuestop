# frozen_string_literal: true

# Stores subcategories to associosate with spents
class Subcategory < ApplicationRecord
  scope :from_category, ->(category_id) { where(category_id:) }
end
