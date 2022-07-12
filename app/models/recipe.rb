class Recipe < ApplicationRecord
  has_one_attached :recipe_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
end
