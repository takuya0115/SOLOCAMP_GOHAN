class Recipe < ApplicationRecord
  has_one_attached :recipe_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  def self.search_for(content, method)
    if method == 'perfect'
      Recipe.where(title: content)
    elsif method == 'forward'
      Recipe.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Recipe.where('title LIKE ?', '%'+content)
    else
      Recipe.where('title LIKE ?', '%'+content+'%')
    end
  end

  def favorited_by?(user)
    # byebug
    favorites.where(user_id: user).exists?
  end

end
