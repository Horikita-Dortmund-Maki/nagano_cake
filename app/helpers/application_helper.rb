module ApplicationHelper
  #　メソッド定義のために使う

  def tax_price(price)
    (price * 1.1).round
  end

  def tax_subtotal(subtotal)
    (price * 1.1 * amount).round
  end



  def tax_total(price)
    @cart_items.each do |cart_item|
      price << cart_item.item.price*1.1* cart_item.amount
    end
    price.sum.round
  end


end
