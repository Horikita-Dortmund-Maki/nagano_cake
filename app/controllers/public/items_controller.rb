class Public::ItemsController < ApplicationController

    def index
      @all_items = Item.all

      @item = Item.where(is_active: true) #販売中ステータスのもの限定で
      @items = @item.page(params[:page]).per(8) #順番に８個まで表示


    end


    def show
        @item = Item.find(params[:id])
        @cart_item = CartItem.new
        # @price = (@item.price*1.1).round
    end



  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
