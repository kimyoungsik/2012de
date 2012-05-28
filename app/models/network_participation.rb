class NetworkParticipation < ActiveRecord::Base
  attr_accessor :network_name

  belongs_to :user
  belongs_to :network, :counter_cache => true

  validates :user_id, :presence => true
  validates :network_id, :presence => true

  validates_uniqueness_of :user_id, :scope => [:network_id]
  
  def network_name
    network.try(:name)
  end
  
  def network_name=(name)
    self.network = Network.find_by_name(name) if name.present?
  end

end
