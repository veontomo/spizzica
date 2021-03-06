#!/bin/env ruby
# encoding: utf-8
class FoodsController < ApplicationController
  before_filter :verify_admin, :except =>[:index,:show,:show_by_foodcategories]

  layout "spizzicaluna_one"
  # GET /foods
  # GET /foods.json

  def show_by_foodcategories
    foodcategorynames = params[:foodcategories_to_display]
    range = []
    if foodcategorynames
     foodcategorynames.each{|name|
      foodcategory=Foodcategory.find_by_name(name)
       if foodcategory
          range << foodcategory.id
         end
    }
    end
    @foods = Food.includes(:foodcategory).where(foodcategories: {id: range})
    render "index"
  end


  def index
    @foods = Food.includes(:foodcategory).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
    @food = Food.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/new
  # GET /foods/new.json
  def new
    @food = Food.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/1/edit
  def edit
    @food = Food.find(params[:id])
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(params[:food])
    params[:ingredient].each{|ingr|
     @food.ingredients << Ingredient.find_by_name(ingr)
    } unless params[:ingredient].blank?


    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render json: @food, status: :created, location: @food }
      else
        format.html { render action: "new" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foods/1
  # PUT /foods/1.json
  def update
    @food = Food.find(params[:id])
    @food.ingredients.clear
    params[:ingredient].each{|ingr|
     @food.ingredients << Ingredient.find_by_name(ingr)
    } unless params[:ingredient].blank?


    respond_to do |format|
      if @food.update_attributes(params[:food])
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :ok }
    end
  end
end
