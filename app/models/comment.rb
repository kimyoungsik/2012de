class Comment < ActiveRecord::Base
  has_many :dittos, :as => :dittoable, :dependent => :destroy
  belongs_to :kit
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :maximum => 3000 }
  validates :kit_id,  :presence => true
end
