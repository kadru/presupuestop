# frozen_string_literal: true

# Give access to subcategories that belongs to a particular category
class SubcategoriesController < ApplicationController
  before_action :authenticate

  def index
    category = current_account.categories.find params.require(:category_id)
    render json: category.subcategories
  end

  def new
    category = Category.new
    category.subcategories.build

    respond_to do |format|
      format.turbo_stream do
        render "subcategories/new",
               locals: {
                 category:,
                 index: params[:index]
               }
      end
    end
  end

  def delete
    category = Category.new
    category.subcategories.build

    render :delete,
           locals: {
             category:,
             index: params[:index],
             id: params[:id]
           }
  end
end
