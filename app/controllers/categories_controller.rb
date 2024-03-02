# frozen_string_literal: true

# Manages categories for a user
class CategoriesController < AuthenticatedController
  def index
    render :index,
           locals: {
             categories: current_account.categories.order_by_name
           }
  end

  def new
    render :new,
           locals: {
             category: current_account.categories.build
           }
  end

  def edit
    render :edit,
           locals: {
             category: current_account_find_category
           }
  end

  def create
    category = current_account.categories.build category_params
    if category.save
      redirect_to categories_path, notice: t(".created")
    else
      render :new,
             locals: {
               category:
             }
    end
  end

  def update
    category = current_account_find_category
    if category.update category_params
      redirect_to categories_path, notice: t(".updated")
    else
      render :edit,
             locals: {
               category:
             }
    end
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

  private

  def category_params
    params
      .require(:category)
      .permit(:name,
              :budget,
              subcategories_attributes:
              %i[id
                 budget
                 _destroy])
  end

  def current_account_find_category
    current_account.categories.find(params[:id])
  end
end
