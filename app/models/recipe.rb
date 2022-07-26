class Recipe < ApplicationRecord
  has_one_attached :recipe_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  def self.search_for(content, method)
    if method == 'perfect'
      Recipe.where(cooking_name: content)
    elsif method == 'forward'
      Recipe.where('cooking_name LIKE ?', content+'%')
    elsif method == 'backward'
      Recipe.where('cooking_name LIKE ?', '%'+content)
    else
      Recipe.where('cooking_name LIKE ?', '%'+content+'%')
    end
  end

  def favorited_by?(user)
    # byebug
    favorites.where(user_id: user).exists?
  end

  validates :cooking_name, presence:true, length:{maximum:50}
  validates :material, presence:true, length:{maximum:100}
  validates :making, presence:true, length:{maximum:400}
  validates :make_time, presence:true, length:{maximum:20}

end
