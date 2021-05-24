class SendAddress < ApplicationRecord
  
  
  belongs_to :customer
  
  validates :postal_code, presence: true, numericality: {only_integer: true}, length: { in: 6..7 }
  validates :address, presence: true
  validates :name, presence: true
end
