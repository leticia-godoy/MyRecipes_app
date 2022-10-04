class Recipe < ApplicationRecord
    validates  :name, presence: true
    validates  :description, presence: true, length: {minimum: 5}
    validates  :sell_price, presence: true
    belongs_to :chef 
    validates  :chef_id, presence: true
    default_scope -> { order(updated_at: :desc)}
    has_many :recipe_ingredients
    has_many :ingredients , through: :recipe_ingredients
end