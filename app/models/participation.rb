class Participation < ActiveRecord::Base  
  belongs_to :user
  belongs_to :seed
    
  #validates_uniqueness_of :user_id, :scope => [:seed_id]      나중에 필요할 것 같아서 
  validates :user_id, :presence => true
  validates :seed_id, :presence => true
  validates_inclusion_of :status, :in => ["progress", "complete"]
  validates_uniqueness_of :user_id, :scope => [:seed_id]
end
