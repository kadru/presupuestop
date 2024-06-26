# frozen_string_literal: true

# Manange accounts for this app
class Account < ApplicationRecord
  include Rodauth::Model(RodauthMain)
  enum :status, unverified: 1, verified: 2, closed: 3

  has_many :expenses, dependent: :destroy
  has_many :expenses_ordered_with_category_subcategory,
           lambda {
             merge(Expense.with_category_subcategory)
               .merge(Expense.ordered)
           },
           class_name: "Expense",
           dependent: :destroy,
           inverse_of: :account do
    def by_month(month)
      merge(Expense.by_month(month))
    end
  end

  has_many :categories, dependent: :destroy do
    def for_select
      pluck(:name, :id)
    end
  end

  def create_categories!
    Config.categories.each do |category_data|
      categories.create!(name: category_data.fetch(:name)).then do |category|
        category_data.fetch(:subcategories).each do |subcategory_data|
          category.subcategories.create!(name: subcategory_data.fetch(:name))
        end
      end
    end
  end

  def total_amount_expenses_by_month(date)
    Expense.total_amount_by_month_and_account(account_id: id, date:)
  end
end
