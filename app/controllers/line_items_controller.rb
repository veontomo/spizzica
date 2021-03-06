#!/bin/env ruby
# encoding: utf-8

class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    item = Item.find(params[:item_id])
    quantity = params[:quantity] || 1
    @line_item = @cart.add_item(item.id,quantity.to_i)


    respond_to do |format|
      if @line_item.save
        # to come back not to the beginning of the page, but to the place where
        # the click was done
        env["HTTP_REFERER"] += '#' + item.id.to_s
        format.html { redirect_to :back, notice: "L'oggetto è stato aggiunto con successo" }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        env["HTTP_REFERER"] += '#' + item.id.to_s
        format.html { redirect_to :back, notice: "Aggiornato con successo." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    # @line_item = LineItem.find(params[:id])
    # @line_item.destroy
    @cart = current_cart
#    item = Item.find(params[:item_id])
    quantity = params[:quantity] || 1
    item_id=params[:item_id]
    @line_item = @cart.delete_item(item_id,quantity.to_i)

    respond_to do |format|
      format.html { redirect_to :back, notice: "L'oggetto è stato rimosso dal carrello!" }
      format.json { head :ok }
    end
  end
end
