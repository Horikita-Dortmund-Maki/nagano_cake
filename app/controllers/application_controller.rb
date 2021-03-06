class ApplicationController < ActionController::Base


   before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :set_search
   add_flash_types :success, :info, :warning, :danger

  def set_search
    @search = Item.ransack(params[:q])
    @items = @search.result
  end

  # def after_sign_up_path_for(resource)
  #   items_path(resource)
  # end



  protected

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_items_path
    when Customer
      customer_path(resource)
    end
  end



  def after_sign_out_path_for(scope)
    case scope
    when :admin
      new_admin_session_path
      #'/admins/sign_in'
    when :customer
      root_path
    end
  end

  # def after_sign_out_path_for(resource_or_scope)
  #   if resource_or_scope == :admin
  #     new_admin_session_path
  #   else
  #     root_path
  #   end
  # end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_out, keys: [:email])
  end

  def configure_permitted_parameters
    if resource_class == Customer
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :id_deleted])
    end
  end

end
