class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item


  def current_cart
    if current_user
      # ユーザーとカートの紐付け
      current_cart = current_user.cart || current_user.create_cart!
    else
      # セッションとカートの紐付け
      current_cart = CartItem.find_by(id: session[:cart_item_id]) || CartItem.create
      session[:cart_item_id] ||= current_cart.id
    end
    current_cart
  end

end
