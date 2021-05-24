module ApplicationHelper

  #　メソッド定義のために使う


  def tax_price(price)
    (price * 1.1).round
  end


  def tax_subtotal(price,amount)
    (price * amount * 1.1 ).round
  end

  def tax_total_price(price)
    array = []
    price.each do |cart_item|
      array << cart_item.item.price * 1.1 * cart_item.amount
    end
    array.sum.round
  end


end
          