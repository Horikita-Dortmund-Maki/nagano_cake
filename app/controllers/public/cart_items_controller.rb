class Public::CartItemsController < ApplicationController
  before_action :setup_cart_item, only: [:add_item, :update, :destroy]
  before_action :authenticate_customer!

  # カート内アイテムの表示
  def show
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end


  # def add_item
  #   @cart_item ||= current_cart.cart_items.build(item_id: params[:item_id])
  #   @cart_item.quantity += params[:amount].to_i
  #   if  @cart_item.save
  #     flash[:notice] = '商品が追加されました。'
  #     redirect_to cart_item_path(current_customer)
  #   else
  #     flash[:alert] = '商品の追加に失敗しました。'
  #     redirect_to item_url(params[:item_id])
  #   end
  # end
    # アイテムの追加
  def add_item
    if @cart_item.blank?
      @cart_item = current_customer.cart_items.build(item_id: params[:item_id])
    end

    @cart_item.amount += params[:amount].to_i
    @cart_item.save
    redirect_to cart_item_path(current_customer)
  end


  # アイテムの更新
  def update_item
    if @cart_item.update(amount: params[:amount].to_i)
      flash[:notice] = 'カート内のギフトが更新されました'
    else
      flash[:alert] = 'カート内のギフトの更新に失敗しました'
    end
    redirect_to cart_item_path(current_customer)
  end

  # アイテムの削除
  def delete_item
    if @cart_item.destroy
      flash[:notice] = 'カート内のギフトが削除されました'
    else
      flash[:alert] = '削除に失敗しました'
    end
    redirect_to cart_item_path(current_customer)
  end

  private

  def setup_cart_item!
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
  end

end
