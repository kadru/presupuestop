# frozen_string_literal: true

# Serializes total amounts by categories
class CategoryAmountResource
  def initialize(category_amounts)
    @category_amounts = category_amounts
  end

  def serialize
    category_amounts.map do |category, amount|
      {
        groupId: category[0],
        name: category[1],
        value: amount / Expense::FACTOR
      }
    end
  end

  private

  attr_reader :category_amounts
end
