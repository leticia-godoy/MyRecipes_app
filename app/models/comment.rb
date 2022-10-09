class Comment < ApplicationRecord
    validates :description, presence: true, length: {maximum: 140}
    belongs_to :chef
    belongs_to :recipe
    validates :chef_id, presence: true
    validates :recipe_id,presence: true
    #latest comment always being in the top of the list
    default_scope -> { order(updated_at: :desc)}
end