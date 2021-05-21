class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  def self.total_amount(order_details)
    order_details.all.sum(:amount)
  end

  def self.item_price_in_tax(order_detail)
    @@result = order_detail.item.price*1.1
    return @@result.round(0)
  end

  def self.item_price_subtotal(order_detail)
    #result_subtotal = order_detail.item.price*1.1*order_detail.amount
    @@result_subtotal = @@result*order_detail.amount
    return @@result_subtotal.round(0)
  end

  enum status: {
    '入金待ち':0, '入金確認':1, '製作中':2, '発送準備中':3, '発送済み':4
  }

  enum payment_method: {
    'クレジット':0, '銀行振り込み':1
  }

  enum payment_method:{
    'クレジットカード': 0,
    '銀行振込': 1
  }
  
  attr_accessor :address_select
  attr_accessor :send_address_id
  
    
    
    
end

