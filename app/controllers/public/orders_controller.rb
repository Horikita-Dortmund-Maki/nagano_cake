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
     @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order_detail = OrderDetail.find(params[:id])
  end
  
 private
  def order_params
    params.require(:order).permit(:payment_method, :address)
  end
end
