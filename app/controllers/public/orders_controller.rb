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
    @send_address = SendAddress.find(params[:order][:send_address_id])
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
   
  end
  
  def index
    
  end

  def show
  end
  
 private
  def order_params
    params.require(:order).permit(:payment_method, :address, :name, :postal_code, :address_select, :send_address_id, :total_payment)
  end
end


