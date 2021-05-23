class Public::CartItemsController < ApplicationController
  before_action :setup_cart_item!, only: [:create, :update, :destroy]
  before_action :authenticate_customer!

  # カート内アイテムの表示
  def show
    @cart_items = current_customer.cart_items
    # @total = CartItem
    # @total = CartItem.all.sum(:price). #CartItemモデルには価格カラムがないためNG
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }　＃このやり方は無駄に難易度高い
    @cart_item = CartItem.find_by(params[:id])
  end


    # アイテムの追加
  def create
     @cart_item = current_customer.cart_items.build(cart_item_params)
      if  @cart_item.save
          redirect_to cart_item_path(current_customer), success: "カートに商品を追加しました"
      else
           flash.now[:danger] = '商品を指定してください。'#課題点ここを渡された数字で判別できるようにしたい！
           render template: "public/items/show"
      end
    
  end


  # アイテムの更新
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params) #ここで変更した数量を受け取って強制的に反映する
      flash[:notice] = '数量が更新されました'
    else
      flash[:alert] = '数量の更新に失敗しました'
    end
    redirect_to cart_item_path(current_customer)
  end

  # アイテムの削除
  def destroy

    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = current_customer.cart_items
    # redirect_to cart_item_path(current_customer)
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all #Whereは主キー以外の一部データ findは主キーのみで紐づくすべてのデータ
    @cart_items = current_customer.cart_items
    #   flash[:notice] = 'カート内のすべての商品が削除されました'
    # else
    #   flash[:alert] = 'カートを空にできませんでした'
    # end
    # redirect_to cart_item_path(current_customer)
    @order_details = Order.where(order_id: current_customer.id)

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

  def setup_cart_item!
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
  end

end
