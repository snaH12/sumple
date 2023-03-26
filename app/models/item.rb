class Item < ApplicationRecord
　#ジャンルに属する
　belongs_to :genre
　#カートアイテムをたくさん持っている
  has_many :cart_items, dependent: :destroy
  #注文詳細をたくさん持つ（注文詳細にはアイテム）
  has_many :order_details
  #scope :スコープの名前, -> (引数){ 条件式 }
  #whereメソッド：モデル名.where(カラム名: 値)
  scope :search_genre, ->(genre) {where(genre_id: genre)}
  
  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :is_active, inclusion: [true, false]
  
  has_one_attached :image
  
def get_image
    (image.attached?) ? image : 'no_image.jpg'
end
#税込み計算
def add_tax_price
    (price*1.1).floor
end
  
end
