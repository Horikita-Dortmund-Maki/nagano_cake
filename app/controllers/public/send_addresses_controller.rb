class Public::SendAddressesController < ApplicationController
  
  def create
    @send_address = SendAddress.new(send_address_params)
    @send_address.customer_id = current_customer.id
    @send_address.save
    redirect_to send_addresses_path
  end
  
  def index
    @customer = current_customer
    @send_addresses = @customer.send_addresses
    @send_address = SendAddress.new
  end
  
  def edit
    @send_address = SendAddress.find(params[:id])
  end
  
  def update
    @send_address = SendAddress.find(params[:id])
    if @send_address.update(send_address_params)
      redirect_to send_addresses_path,notice: "You have updated address successfully."
    else
      render "edit"
    end
  end
  
  def destroy
    @send_address = SendAddress.find(params[:id])
    @send_address.destroy
    redirect_to send_addresses_path
  end
  
  private
  
  def send_address_params
    params.require(:send_address).permit(:postal_code, :address, :name)
  end
end
