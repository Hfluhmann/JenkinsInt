class Recipe < ApplicationRecord
    validates :title, presence: true, length: {minimum: 2} 
    validates :ingredients, presence: true, length: {minimum: 5} 
    validates :instructions, presence: true, length: {minimum: 5}
    has_one_attached :image
end
