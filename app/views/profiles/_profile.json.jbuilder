json.extract! profile, :id, :avatar_data, :username, :user_id, :bio, :created_at, :updated_at
json.url profile_url(profile, format: :json)
