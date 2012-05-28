class Moim < ActiveRecord::Base
  has_many :kits, :as => :kitable, :dependent => :destroy

  default_scope :order => 'moims.updated_at DESC'
end
