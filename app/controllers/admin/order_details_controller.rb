class Admin::OrderDetailsController < ApplicationController

  def update
    #@order = Order.find(params[:id])
    #@order_details = OrderDetail.all
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)
      if @order_detail.making_status == '製作中'
        @order_detail.order.update(status: 2)

      elsif @order_detail.making_status == '製作完了'
        check = []
        @order_details.each do |order_detail|
          check << order_detail.making_status
        end
        judge = check.all?{|i| i == '製作完了'}
        if judge == true
          @order_detail.order.update(status: 3)
        end

      end
      redirect_to admin_order_path(@order_detail.order_id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :making_status)
  end

end
