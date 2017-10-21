class Photo < ApplicationRecord
  include ImageUploader[:image]
  # include ImageUploader::Attachment.new[:image]

  validates :user_id, presence: true

  belongs_to :user
  has_and_belongs_to_many :likers, class_name: 'User', join_table: :likes
  has_many :comments

  #  this line below mean: he dependent: destroy line means that if that object is destroyed, the associated objects will be destroyed too. In practice, this’ll mean that if a User is destroyed, all of their associated comments will too. If a Photo is deleted, say “Goodbye” to the comments too!

  # has_many :comments, dependent: :destroy

  # acts_as_votable

  # photo user_id likes
  def liked_by?(user)
    likers.exists?(user.id)
  end

  def toggle_liked_by(user)
    if likers.exists?(user.id)
      likers.destroy(user.id)
    else
      likers << user
    end

  end

  def commenter_username(user_id)
    # puts "SELF: #{self.inspect}"
    # puts "USER: #{User.find(user_id)}"
    user = User.find(user_id)
    user_profile = user.profile
    username = user_profile.username
  end
end
