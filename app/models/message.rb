class Message < ActiveRecord::Base
  attr_accessible :user_tokens, :title, :content, :participant_ids
  attr_accessor :content, :participant_ids
  attr_reader :user_tokens
  
  has_many :message_participations, :dependent => :destroy
  has_many :replies, :dependent => :destroy
  has_many :users, :through => :message_participations
  has_many :message_participants, :through => :message_participations, :source => :user
  
  validates :title, :presence => true,
                    :length => { :maximum => 140 }
  validates :content, :presence => true,
                    :length => { :maximum => 10000 }

  default_scope :order => 'messages.created_at DESC'

  def user_tokens=(ids)
    self.participant_ids = ids.split(",")  
  end
end