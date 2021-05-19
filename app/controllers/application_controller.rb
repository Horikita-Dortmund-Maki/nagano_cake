class ApplicationController < ActionController::Base
  
   before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :set_search

  def after_sign_in_path_for(resource)
    admin_items_path(resource)
  end
  
  def set_search

    @search = Item.ransack(params[:q])
    @items = @search.result
  end 
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :id_deleted])
  end
  
end
