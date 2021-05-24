class HomesController < ApplicationController
    def top
      @all_items = Item.all
      @item = Item.where(is_active: true) #販売中ステータスのもの限定で
      @items = @item.page(params[:page]).per(4) #順番に８個まで表示
    end

    def about
    end
end
