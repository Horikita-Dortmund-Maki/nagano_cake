class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(1)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    #binding.pry
      if @order.status == '入金確認'
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: 1)
        end
      end
      redirect_to admin_order_path(@order)
  end

  private

  def order_params
    #params.permit(:customer_id, :postal_code, :address, :name, :shopping_cost, :total_payment, :payment_method, :status)
    params.permit(:status)
  end
end
