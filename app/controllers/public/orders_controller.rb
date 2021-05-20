class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    @send_addresses = @customer.send_addresses
  end
  
  def confirm
    @order = Order.new(order_params)
    @shopping_cost = 800
    @customer = current_customer
   
    if params[:order][:address_select] == "0"
     @order.postal_code = @customer.postal_code
     @order.address = @customer.address
     @order.name = @customer.first_name + @customer.last_name
    elsif params[:order][:address_select] == "1"
     @hoge = SendAddress.find(params[:order][:send_address_id])
     @order.postal_code = @hoge.postal_code
     @order.address = @hoge.address
     @order.name = @hoge.name
    else
     @order.postal_code = params[:order][:postal_code]
     @order.address = params[:order][:address]
     @order.name = params[:order][:name]
    end
  
    
    @cart_items = @customer.cart_items
    
    array = []
     @cart_items.each do |cart_item|
     array << cart_item.item.price * cart_item.amount
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
   end
   
  

   redirect_to thanks_path
  end
  
  def index
    
  end

  def show
  end
  
 private
  def order_params
    params.require(:order).permit(:payment_method, :address, :name, :postal_code, :address_select, :send_address_id, :total_payment, :shopping_cost)
  end
end


