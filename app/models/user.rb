class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :photos
  has_many :comments
  has_one :profile

  has_many :likes


  #  this line below mean: he dependent: destroy line means that if that object is destroyed, the associated objects will be destroyed too. In practice, this’ll mean that if a User is destroyed, all of their associated comments will too. If a Photo is deleted, say “Goodbye” to the comments too!

  # has_many :comments, dependent: :destroy

  # has_many :followers

  # The people who follow me
  has_and_belongs_to_many :followers, class_name: 'User', join_table: :followers, foreign_key: :followed_id, association_foreign_key: :follower_id

  # I follow the people
  has_and_belongs_to_many :following, class_name: 'User', join_table: :followers, foreign_key: :follower_id, association_foreign_key: :followed_id


  def followed_by?(user)
    followers.exists?(user.id)
  end


  def toggle_followed_by(user)
      if followers.exists?(user.id)
         followers.destroy(user)
      else
        followers << user
      end
  end

  scope :top_followed, -> {join(:followers).group(:followed_id).order('count(follower_id) DESC')}


end
