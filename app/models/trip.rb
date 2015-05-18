class Trip < ActiveRecord::Base

  has_many :tripdetails,  dependent:  :destroy
  #has_many :users, through: :hunts
  validates :latitude, presence: true
  validates :longitude, presence: true

  validates :name, presence: true,
  length: {
  minimum: 4,
  maximum: 50
  }

  validates :description, presence: true,
   length: { maximum: 1000 }

  validates :address, presence: true

  geocoded_by :address
  before_validation :geocode, :if => :address_changed?



end
