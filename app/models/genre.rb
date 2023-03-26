class Genre < ApplicationRecord
    has_many :items
    #空禁止
    validates :name, presence:true
end
