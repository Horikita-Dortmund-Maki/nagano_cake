class Public::CartItemsController < ApplicationController
  before_action :setup_cart_item!, only: [:create, :update, :destroy]
  before_action :authenticate_customer!

  # カート内アイテムの表示
  def show
    @cart_items = current_customer.cart_items
    # @total = CartItem
    # @total = CartItem.all.sum(:price). #CartItemモデルには価格カラムがないためNG
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }　＃このやり方は無駄に難易度高い
    @cart_item = CartItem.find(params[:id])
  end


    # アイテムの追加
  def create
    # if @cart_item.blank?
    #   @cart_item = current_customer.cart_items.build(item_id: params[:item_id])
    # end
    @cart_item = current_customer.cart_items.build(cart_item_params)
    # @cart_item.amount += params[:amount].to_i
    @cart_item.save
    redirect_to cart_item_path(current_customer)
  end


  # アイテムの更新
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params) #ここで変更した数量を受け取って強制的に反映する
    # if @cart_item.update(amount: params[:amount].to_i)
      flash[:notice] = '数量が更新されました'
    else
      flash[:alert] = '数量の更新に失敗しました'
    end
    redirect_to cart_item_path(current_customer)
  end

  # アイテムの削除
  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      flash[:notice] = 'カート内のギフトが削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to cart_item_path(current_customer)
  end

  def destroy_all
    CartItem.destroy_all
    if @cart_item.destroy_all
      flash[:notice] = 'カート内のすべてのギフトが削除されました'
    else
      flash[:alert] = 'カートを空にするアクションが失敗しました'
    end
    redirect_to cart_item_path(current_customer)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

  def setup_cart_item!
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
  end

end
