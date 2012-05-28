class Ditto < ActiveRecord::Base
  attr_accessible :dittoable_id, :dittoable_type
  
  belongs_to :user
  belongs_to :dittoable, :polymorphic => true
  
  validates :user_id, :dittoable_id, :dittoable_type, :presence => true
  validates_inclusion_of :dittoable_type, :in => ["Kit", "Comment"]
  
end
