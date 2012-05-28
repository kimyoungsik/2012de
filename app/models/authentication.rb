class Authentication < ActiveRecord::Base
  belongs_to :user
  
  def self.have_facebook_id(user)
     return true unless find_by_user_id(user).nil?
     false
  end
  
  def self.is_dreamkit_member(uid)  
      return find_by_provider_and_uid("facebook",uid)
  end

end
