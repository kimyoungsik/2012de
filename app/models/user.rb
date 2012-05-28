class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable :omniauthable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable, :encryptor => :sha1

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # 
  # 
  attr_accessor :avatar_url 
  # attr_accessible :name, :email, :password, :password_confirmation, :avatar, :avatar_url
 
  has_many :authentications, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :dittos, :dependent => :destroy
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships, 
                      :conditions => "status = 'accepted'",
                      :order => :name
  has_many :requested_friends, :through => :friendships,
                                :source => :friend,
                                :conditions => "status = 'requested'",
                                :order => :created_at
  has_many :pending_friends, :through => :friendships,
                                :source => :friend,
                                :conditions => "status = 'pending'",
                                :order => :created_at                                                    
  has_many :kits, :as => :kitable, :dependent => :destroy
  has_many :authored_kits, :class_name => "Kit", :dependent => :destroy
  has_many :message_participations, :dependent => :destroy
  has_many :messages, :through => :message_participations, :source => :message  
  has_many :unread_messages, :class_name => "MessageParticipation", :conditions => { :read => false }
  has_many :network_participations, :dependent => :destroy
  has_many :networks, :through => :network_participations, :source => :network
  has_many :notifications, :dependent => :destroy
  has_many :sent_notifications, :class_name => "Notification", :foreign_key => :sender_id, :dependent => :destroy
  has_one :notification_setting, :dependent => :destroy
  has_many :unread_notifications, :class_name => "Notification", :conditions => { :read => false }
  has_many :participations, :dependent => :destroy
  has_many :authored_photos, :class_name => "Photo", :dependent => :destroy
  has_many :photos, :as => :photoable, :dependent => :destroy
  has_many :replies, :dependent => :destroy
  has_many :seeds, :dependent => :destroy
  has_many :progress_seeds, :through => :participations, :source => :seed, :conditions => "status = 'progress'"
  has_many :complete_seeds, :through => :participations, :source => :seed, :conditions => "status = 'complete'"
  has_many :supports, :dependent => :destroy


  # 
  validates :name, :presence => true
  # validates :email, :presence => true
  # validates :password, :presence => true,
  #                       :confirmation => true,
  #                       :length => { :within => 6..40}
  #                       
  default_scope :order => 'users.avatar_content_type is not NULL DESC, users.updated_at DESC'
  scope :with_photo, where( "avatar_content_type <> ''" )
  scope :without_photo, where( "avatar_content_type is NULL" )

  has_attached_file :avatar, 
                    :default_url => :facebook_profile_photo, 
                    :processors => [:cropper],
                    :styles => {
                      :thumb => "50x50#",
                      :small => "100x100#"}
  
    
  alias :devise_valid_password? :valid_password?
  
  def profile_photo
    photos.first
  end
  
  def supports?(seed)
    Support.where(:user_id => self.id, :seed_id => seed.id).any?
  end

  def participates_in?(seed)
    Participation.where(:user_id => self.id, :seed_id => seed.id).any?
  end
  
  def complete?(seed)
    Participation.where(:user_id => self.id, :seed_id => seed.id, :status => 'complete' ).any?
  end
    
  def facebook_profile_photo
    facebook_auth = self.authentications.where(:provider => "facebook")
    if facebook_auth.any?
      "http://graph.facebook.com/#{self.authentications.where(:provider => "facebook").last.uid}/picture?type=large"
    else 
      "/assets/default_profile.png"
    end
  end
  
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], 
                          :uid => omniauth['uid'], 
                          :token => omniauth['credentials']['token'])
  end
  
  def valid_password?(password)
    if devise_valid_password?(password)
      return true
    elsif Digest::SHA2.hexdigest("#{self.password_salt}--#{password}") == self.encrypted_password
      self.encrypted_password = self.password_digest(password) 
      self.save
      return true
    else
        # If not BCryt password and not old Authlogic SHA512 password Dosn't my user
      return false
      
    end
  end
end
