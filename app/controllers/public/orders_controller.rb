class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
    
  end
  
  def confirm
    @order = Order.new(order_params)
    @shopping_cost = 800
    
  end
  
  
  def create
   
  end
  
  def index
    
  end

  def show
    
  end
  
 private
  def order_params
    params.require(:order).permit(:payment_method, :address)
  end
end
