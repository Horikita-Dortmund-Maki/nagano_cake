class Public::AddressesController < ApplicationController
  
  def index
    @customer = current_customer
    @addresses = @customer.Addresses
    @address = Address.new
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path,notice: "You have updated address successfully."
    else
      render "edit"
    end
  end
  
  
  private
  
  def address_params
    params.require(:address).permit(:)
  
end
