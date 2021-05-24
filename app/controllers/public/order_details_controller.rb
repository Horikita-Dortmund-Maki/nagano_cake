class Public::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail.params)
      redirect_to admin_order_path()
    else
      @orders = Order.all
      render template: 'order/index'
    end
  end

  private

  def order_detail.params
    params.permit(:making_status)
  end
end
