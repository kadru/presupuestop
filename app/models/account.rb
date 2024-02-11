# frozen_string_literal: true

# Manange accounts for this app
class Account < ApplicationRecord
  include Rodauth::Model(RodauthMain)
  enum :status, unverified: 1, verified: 2, closed: 3

  has_many :expenses, dependent: :destroy
  has_many :expenses_ordered_with_category_subcategory,
           -> { merge(Expense.ordered_with_category_subcategory) },
           class_name: "Expense",
           dependent: :destroy,
           inverse_of: :account
end
