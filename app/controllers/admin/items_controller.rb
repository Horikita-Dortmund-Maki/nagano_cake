class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
  end
  



  def show
    @item = Item.find(params[:id])
    #@genre = Genre.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, success: "作成しました"
    else
      flash.now[:danger] = '作成に失敗しました。'
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(), success: "更新しました"
    else
      flash.now[:danger] = '作成に失敗しました。'
      render :edit
    end
  end
  

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end
