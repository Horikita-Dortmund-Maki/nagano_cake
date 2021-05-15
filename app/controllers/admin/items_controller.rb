class Admin::ItemsController < ApplicationController
  
  def index
    @items = Items.all
  end
  
  def show
    @item = Item.find(params[:id])
    @genre = Genre.find(params[:id])
  end
  
  def new
    @item = Item.new
    @genres = Genres.all
  end
  
  def create
    @item = Item.new(params[:id])
    if @item.save
      redirect_to path #depend on routes
    else
      render :index
    end
  end
  
  def edit
    @item = Item.find(params[:id])
    @genre = Genres.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to #showpage
    else
      render :edit
    end
  end
end
