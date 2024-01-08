# frozen_string_literal: true

# Gives to spents a custom category to belong
class Category < ApplicationRecord
  def self.for_select
    pluck(:name, :id)
  end

  has_many :subcategories, dependent: :destroy
end
