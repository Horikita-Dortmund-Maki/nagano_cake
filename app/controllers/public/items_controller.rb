class Public::ItemsController < ApplicationController

    def index
      @all_items = Item.all
      @items = Item.page(params[:page]).per(8)
        # @price = (item.params.price*1.1).round
    end


    def show
        @item = Item.find(params[:id])
        @cart_item = CartItem.new
        # @price = (@item.price*1.1).round
    end







end
