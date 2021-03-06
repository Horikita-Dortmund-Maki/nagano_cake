class Item < ApplicationRecord


  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
    validates :genre_id, presence: true
    validates :name, presence: true,length: { minimum: 1, maximum: 20 }
    validates :introduction, presence: true,length: { minimum: 1, maximum: 100 }
    validates :price,numericality: {greater_than: 0}
    validates :is_active, inclusion: { in: [true, false] }


  attachment :image

end
