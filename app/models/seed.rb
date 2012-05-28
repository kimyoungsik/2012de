class Seed < ActiveRecord::Base
  belongs_to :user
  has_many :kits, :as => :kitable, :dependent => :destroy
  has_many :participations
  has_many :participants, :through => :participations, :source => :user
  has_many :supports, :dependent => :destroy
  has_many :progress, :through => :participations, :source => :user, :conditions => "status = 'progress'"
  has_many :complete, :through => :participations, :source => :user, :conditions => "status = 'complete'"
  has_many :supporters, :through => :supports, :source => :user
  
  # include Tire::Model::Search
  # include Tire::Model::Callbacks
  
  
  searchable do
    text :title, :boost => 5
    text :description
    text :kits do
      kits.map(&:content)
    end
  end
  
  validates :title, presence: true, :length => { :maximum => 140 }
  validates :description, presence: true, :length => { :maximum => 10000 }
  validates :user_id, :presence => true
  # def self.search(params)
  #   tire.search(load: true) do
  #     query { string params[:query]} if params[:query].present?
  #   end
  # end
  
  def point
    self.participations.count * 4 + self.supports.count * 2 + self.kits.count
  end

  default_scope :order => 'seeds.updated_at DESC'
  
end
