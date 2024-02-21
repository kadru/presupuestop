# frozen_string_literal: true

# Manages categories for a user
class CategoriesController < AuthenticatedController
  def index
    render :index,
           locals: {
             categories: current_account.categories
           }
  end

  def destroy
    category = current_account.categories.find params[:id]
    category.destroy

    respond_to do |format|
      format.html { redirect_to categories_path }
      format.turbo_stream do
        render :destroy,
               locals: { category: }
      end
    end
  end
end
