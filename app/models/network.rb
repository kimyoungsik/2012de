class Network < ActiveRecord::Base
  attr_accessible :name, :network_type, :address
  
  has_many :network_participations, :dependent => :destroy
  has_many :network_participants, :through => :network_participations, :source => :user 
  has_many :kits, :as => :kitable, :dependent => :destroy
  
  searchable do
    text :name
  end
  
  validates :name, :network_type, :address, :presence => true
  
  default_scope :order => "networks.network_participations_count DESC, networks.created_at"
end
