# frozen_string_literal: true

# Give access to subcategories that belongs to a particular category
class SubcategoriesController < ApplicationController
  def index
    render json: Subcategory.from_category(params.require(:category_id))
  end
end
