class Recipe < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: {minimum: 5}
    validates :sell_price, presence: true
end