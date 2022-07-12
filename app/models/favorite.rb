class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
