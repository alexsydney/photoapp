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

  has_many :followers

  has_and_belongs_to_many :followers, class_name: 'User'
end
