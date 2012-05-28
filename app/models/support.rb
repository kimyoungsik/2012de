class Support < ActiveRecord::Base
  belongs_to :user 
  belongs_to :seed

  validates :user_id, :presence => true
  validates :seed_id, :presence => true
end
