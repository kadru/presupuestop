# frozen_string_literal: true

# Transforms the amount in cents to the amount in the currency unit
class AmountUnit < SimpleDelegator
  def initialize(amount)
    super(amount / Expense::FACTOR)
  end
end
