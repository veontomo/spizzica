class SandwichesController < ApplicationController
  layout "spizzicaluna_one"
  helper_method :sort_column, :sort_direction

  before_filter :verify_admin, :except =>[:index,:show]
  # GET /sandwiches
  # GET /sandwiches.json
  def index
    @sandwiches = Sandwich.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sandwiches }
    end
  end

  # GET /sandwiches/1
  # GET /sandwiches/1.json
  def show
    @sandwich = Sandwich.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sandwich }
    end
  end

  # GET /sandwiches/new
  # GET /sandwiches/new.json
  def new
    @sandwich = Sandwich.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sandwich }
    end
  end

  # GET /sandwiches/1/edit
  def edit
    @sandwich = Sandwich.find(params[:id])
  end

  # POST /sandwiches
  # POST /sandwiches.json
  def create
    @sandwich = Sandwich.new(params[:sandwich])
    params[:ingredient].each{|ingr|
      @sandwich.ingredients << Ingredient.find_by_name(ingr)
    }


    respond_to do |format|
      if @sandwich.save
        format.html { redirect_to @sandwich, notice: 'Sandwich was successfully created.' }
        format.json { render json: @sandwich, status: :created, location: @sandwich }
      else
        format.html { render action: "new" }
        format.json { render json: @sandwich.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sandwiches/1
  # PUT /sandwiches/1.json
  def update
    @sandwich = Sandwich.find(params[:id])
    @sandwich.ingredients.clear
    params[:ingredient].each{|ingr|
     @sandwich.ingredients << Ingredient.find_by_name(ingr)
    }

    respond_to do |format|
      if @sandwich.update_attributes(params[:sandwich])
        format.html { redirect_to @sandwich, notice: 'Sandwich was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sandwich.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sandwiches/1
  # DELETE /sandwiches/1.json
  def destroy
    @sandwich = Sandwich.find(params[:id])
    @sandwich.destroy

    respond_to do |format|
      format.html { redirect_to sandwiches_url }
      format.json { head :ok }
    end
  end

  private
  def sort_column
    Sandwich.column_names.include?(params[:sort]) ? "lower(#{params[:sort]})" : "lower(name)"
  end
end
