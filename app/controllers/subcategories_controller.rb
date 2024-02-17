# frozen_string_literal: true

# Give access to subcategories that belongs to a particular category
class SubcategoriesController < ApplicationController
  before_action :authenticate

  def index
    category = current_account.categories.find params.require(:category_id)
    render json: category.subcategories
  end
end
