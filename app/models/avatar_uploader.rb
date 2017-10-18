require "image_processing/mini_magick"

class AvatarUploader < Shrine
  include ImageProcessing::MiniMagick
  # plugins and uploading logic
  plugin :processing
  plugin :versions
  plugin :cached_attachment_data
  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :delete_raw # delete processed files after uploading

  process(:store) do |io, context|
    resize_to_limit!(io.download, 800, 800) { |cmd| cmd.auto_orient } # orient rotated images
  end
end
