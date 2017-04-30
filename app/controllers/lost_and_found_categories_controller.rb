class LostAndFoundCategoriesController < ApplicationController
  before_action :set_lost_and_found_category, only: [:show, :edit, :update, :destroy]

  # GET /lost_and_found_categories
  # GET /lost_and_found_categories.json
  def index
    @lost_and_found_categories = LostAndFoundCategory.order(:name)
  end

  # GET /lost_and_found_categories/1
  # GET /lost_and_found_categories/1.json
  def show
  end

  # GET /lost_and_found_categories/new
  def new
    @lost_and_found_category = LostAndFoundCategory.new
  end

  # GET /lost_and_found_categories/1/edit
  def edit
  end

  # POST /lost_and_found_categories
  # POST /lost_and_found_categories.json
  def create
    @lost_and_found_category = LostAndFoundCategory.new(lost_and_found_category_params)

    respond_to do |format|
      if @lost_and_found_category.save
        format.html { redirect_to @lost_and_found_category, notice: 'Lost and found category was successfully created.' }
        format.json { render :show, status: :created, location: @lost_and_found_category }
      else
        format.html { render :new }
        format.json { render json: @lost_and_found_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lost_and_found_categories/1
  # PATCH/PUT /lost_and_found_categories/1.json
  def update
    respond_to do |format|
      if @lost_and_found_category.update(lost_and_found_category_params)
        format.html { redirect_to @lost_and_found_category, notice: 'Lost and found category was successfully updated.' }
        format.json { render :show, status: :ok, location: @lost_and_found_category }
      else
        format.html { render :edit }
        format.json { render json: @lost_and_found_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lost_and_found_categories/1
  # DELETE /lost_and_found_categories/1.json
  def destroy
    @lost_and_found_category.destroy
    respond_to do |format|
      format.html { redirect_to lost_and_found_categories_url, notice: 'Lost and found category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lost_and_found_category
      @lost_and_found_category = LostAndFoundCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lost_and_found_category_params
      params.require(:lost_and_found_category).permit(:name)
    end
end
