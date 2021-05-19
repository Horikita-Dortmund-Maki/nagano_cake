class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  enum payment_method:{
    'クレジットカード': 0,
    '銀行振込': 1
  }
  
  attr_accessor :address_select
  attr_accessor :send_address_id
  
    
    
    
end

