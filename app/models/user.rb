class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_recipes, through: :favorites, source: :recipe
  has_many :comments, dependent: :destroy

    # フォローしている側のユーザー (active relationship)
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  # フォローされている側のユーザー(passive relationship)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # ユーザーをフォロー
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォロー
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 相手をフォローしていればtrueを返す
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  # 友達（互いにフォローしている）をデータベースから取得
  def matchers
    followings & followers
  end

  # 相手と友達になっていればtrueを返す
  def matchers?(other_user)
    active_relationships.find_by(followed_id: other_user.id) && passive_relationships.find_by(follower_id: other_user.id)
  end

  # 自分はフォローしていない&相手からフォローされていればtrueを返す
  def follow_request?(user, other_user)
    !user.matchers?(other_user) && other_user.following?(user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

end
