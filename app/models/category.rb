# frozen_string_literal: true

# Gives to spents a custom category to belong
class Category < ApplicationRecord
  belongs_to :account
  has_many :subcategories, dependent: :destroy
end
