class Profile < ApplicationRecord
  include AvatarUploader::Attachment.new(:avatar) # adds an `avatar` virtual attribute

  belongs_to :user
end
