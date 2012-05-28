class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  
  validates :user_id, :presence => true
  validates :message_id, :presence => true
  validates :content, :presence => true,
                      :length => { :maximum => 3000 }
end
