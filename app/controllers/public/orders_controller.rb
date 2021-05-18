class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def confirm
    @order = Order.new(order_params)
  end
  
  def create
    @order = Order.new(order_params)
  
  end
  
  def index
    
  end

  def show
    
  end
  
 
end
