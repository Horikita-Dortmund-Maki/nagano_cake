class Admin::CustomersController < ApplicationController

 def index
      #@customers = Customer.all
        @customers = Customer.page(params[:page]).per(8)
 end

  def show
        @customer = Customer.find(params[:id])
  end

  def edit
        @customer = Customer.find(params[:id])
  end

  def update
       @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to admin_customer_path(@customer.id), success: "更新しました"
    else
       flash.now[:danger] = '更新に失敗しました。'
       render "edit"
    end
  end
 private

     def customer_params
         params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:email,:id_deleted )
     end
end
