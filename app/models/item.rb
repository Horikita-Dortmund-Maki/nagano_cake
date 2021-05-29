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
  
    
  def self.search(search)
    if search != "" #検索フォームに何か値が入力されていた場合
      Item.where(['name LIKE(?) OR genre_id LIKE(?) ', "%#{search}%", "%#{search}%"]) #カラムで検索
    else
      Item.all
    end
  end

end
