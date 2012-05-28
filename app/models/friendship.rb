class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
  validates :user_id, :friend_id, :presence => true
  validates_inclusion_of :status, :in => ["pending", "requested", "accepted"]
  def self.are_friends(user, friend)
    return false if user == friend
    
    return true unless find_by_user_id_and_friend_id_and_status(user, friend, "accepted").nil?
    return true unless find_by_user_id_and_friend_id_and_status(friend, user, "accepted").nil?
    false
  end
  
  def self.pending?(user, friend)
    return false if user == friend
    return true unless find_by_user_id_and_friend_id_and_status(user, friend, "pending").nil?
    false
  end
  
  def self.requested?(user, friend)
    return false if user == friend
    return true unless find_by_user_id_and_friend_id_and_status(user, friend, "requested").nil?
    false
  end
end
