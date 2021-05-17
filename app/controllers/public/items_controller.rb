class Public::ItemsController < ApplicationController

    def index
      @all_items = Item.all
      @items = Item.page(params[:page]).per(8)
    end

    def show
        @item = Item.find(params[:id])
    end




end
