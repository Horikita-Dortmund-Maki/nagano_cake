class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item





  validates :amount, presence: true #個数選択しないまま登録されるを防ぐ

end
