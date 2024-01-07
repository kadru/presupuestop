class SpentsController < ApplicationController
  before_action :set_spent, only: %i[ show edit update destroy ]

  # GET /spents or /spents.json
  def index
    @spents = Spent.all
    render :index,
           locals: {
             spents: Spent.all,
             categories: Category.for_select,
             subcategories: []
           }
  end

  # GET /spents/1 or /spents/1.json
  def show
  end

  # GET /spents/new
  def new
    @spent = Spent.new
    render :new,
           locals: {
            spent: Spent.new,
            categories: Category.for_select,
            subcategories: []
           }
  end

  # GET /spents/1/edit
  def edit
  end

  # POST /spents or /spents.json
  def create
    @spent = Spent.new(spent_params)

    respond_to do |format|
      if @spent.save
        format.html { redirect_to spents_path, notice: t(".successfully_created") }
        format.turbo_stream do
          render :create, locals: { spent: @spent }
        end
      else
        format.html do
          render :new,
                 locals: { 
                  spent: @spent,
                  categories: Category.for_select,
                  subcategories: []
                 },
                 status: :unprocessable_entity
         end
      end
    end
  end

  # PATCH/PUT /spents/1 or /spents/1.json
  def update
    respond_to do |format|
      if @spent.update(spent_params)
        format.html { redirect_to spent_url(@spent), notice: "Spent was successfully updated." }
        format.json { render :show, status: :ok, location: @spent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spents/1 or /spents/1.json
  def destroy
    @spent.destroy!

    respond_to do |format|
      format.html { redirect_to spents_url, notice: "Spent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spent
      @spent = Spent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spent_params
      params
        .require(:spent)
        .permit(:name,
                :amount_unit,
                :category_id,
                :subcategory_id)
    end
end
