class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
    @send_addresses = @customer.send_addresses
  end

  def confirm
    @order = Order.new(order_params)
    @shopping_cost = 800
    @customer = current_customer

   #カートの内容を注文詳細へ
    if params[:order][:address_select] == "0"
     @order.postal_code = @customer.postal_code
     @order.address = @customer.address
     @order.name = @customer.last_name + @customer.first_name
    elsif params[:order][:address_select] == "1"
     if @order.send_address_id.nil?
      redirect_to new_order_path, notice: "登録済み住所がありません"
      return
     end
     @hoge = SendAddress.find(params[:order][:send_address_id])
     @order.postal_code = @hoge.postal_code
     @order.address = @hoge.address
     @order.name = @hoge.name
    else
     @order.postal_code = params[:order][:postal_code]
     @order.address = params[:order][:address]
     @order.name = params[:order][:name]
     if @order.postal_code.empty? || @order.address.empty? || @order.name.empty?
      redirect_to new_order_path, notice: "新しいお届け先を入力してください"
      return
     end
    end


    @cart_items = @customer.cart_items

    #カートが空の場合、購入確認画面へ行けない
    if @cart_items.empty?
     redirect_to new_order_path, notice: "カートが空です"
     return
    end


    #請求金額を変数に代入
    array = []
    @cart_items.each do |cart_item|
    array << (cart_item.item.price * cart_item.amount * 1.1).round
    end
    array << @shopping_cost
    array.sum
    @total_payment = array.sum

  end


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @customer = current_customer
    @cart_items = @customer.cart_items
    @cart_items.each do |cart_item|
     order_detail = OrderDetail.new
     order_detail.item_id = cart_item.item_id
     order_detail.order_id = @order.id
     order_detail.price = cart_item.item.price
     order_detail.amount = cart_item.amount
     order_detail.save!
     cart_item.destroy
    end

     redirect_to thanks_path
  end

  def index
    @customer = current_customer
    @orders = @customer.orders
    #@order = Order.find(params[:id])
    #@order_details = @customer.order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order_detail = OrderDetail.find(params[:id])
  end

 private
  def order_params
    params.require(:order).permit(:payment_method, :address, :name, :postal_code, :address_select, :send_address_id, :total_payment, :shopping_cost)
  end

end


