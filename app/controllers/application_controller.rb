class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_in_path_for(resource)
  #   admin_items_path(resource)
  # end


  # protect_from_forgery with: :exception

  # helper_method :current_cart_item

  # 新規カート追加アクション
  # def current_customer
  #   if session[:cart_item_id]
  #     @cart_items = CartItem.find(session[:cart_items_id])
  #   else
  #     @cart_items = CartItem.create
  #     session[:cart_item_id] = @cart_items.id
  #   end
  # end




  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :id_deleted])
  end

end
