module ProfilesHelper

  def current_user_is_following(current_user_id, follow_user_id)

    relationships = Follow.find_by(folloer_id: current_user_id, following_id: followed_user_id)

    return true if relationship

  end
  
end
