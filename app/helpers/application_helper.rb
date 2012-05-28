# encoding: UTF-8
module ApplicationHelper
  
  def profile_photo(user, size, width)
    if user.profile_photo
      image_tag(user.profile_photo.image.url(size), :width => width)
    elsif user.avatar
      image_tag(user.avatar.url(size), :width => width)
    else
      image_tag('/assets/default_profile.png', :width => width)
    end
  end

  
  def also_liked_by(user, dittoable)
    ditto_friends = []
    dittoable.dittos.each do |ditto|
      ditto_friends.push(current_user) if current_user == ditto.user
			ditto_friends.push(ditto.user) if Friendship.are_friends(current_user, ditto.user)
		end
		ditto_friends
  end
  
  def link_to_user(user)
    link_to user.name, user
  end
  
  def dreamer_in_facebook()
    dreamers  =[]
    @graph.get_connections("me", "friends").each do |friends|
      uid = Authentication.is_dreamkit_member(friends["id"])
      dreamers.push(uid) if uid
    end
    dreamers
  end  
  
  def title
    base_title = "DreamKit"
    if @title.nil?
      base_title
    else
      "#{@title}"
    end
  end
  
  def author
    base_author = "HeadFlow"
    if @author.nil?
      base_author
    else
      "#{@author}"
    end
  end
  
  def revisit_after
    base_revisit_after = "3 days"
    if @revisit_after.nil?
      base_revisit_after
    else
      "#{@revisit_after}"
    end
  end
  
  
  def description
    base_description = "소셜 네트워크"
    if @description.nil?
      base_description
    else
      "#{@description}"
    end
  end
    
  def user_signed_in
    return true if user_signed_in?
    false
  end
  
  def kit_from(kit)
		case kit.kitable_type
		when 'User'
		  kit_from_path = user_path(kit.kitable_id) + "#kit_#{kit.id}"
		  kit_from_words = "#{kit.kitable.name}님의 뜰에 남긴 Kit"
		  
		when 'Seed'
		  kit_from_path = seed_path(kit.kitable_id) + "#kit_#{kit.id}"
		  kit_from_words = "'#{truncate(kit.kitable.title, :length => 25)}'시드에 남긴 Kit"
		  
		when 'Moim'
		  kit_from_path = moim_path(kit.kitable_id) + "#kit_#{kit.id}"
		  kit_from_words = "'#{truncate(kit.kitable.title, :length => 25)}'모임에 남긴 Kit"
		  
		when 'Network'
		  kit_from_path = network_path(kit.kitable_id) + "#kit_#{kit.id}"
		  kit_from_words = "'#{truncate(kit.kitable.name, :length => 25)}'네트워크에 남긴 Kit"
		  
		end

		link_to kit_from_words, kit_from_path
  end
end
