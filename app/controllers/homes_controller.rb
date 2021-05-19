class HomesController < ApplicationController
    def top
      @all_items = Item.all
      @items = Item.page(params[:page]).per(4)
    end

    def about
    end
end
