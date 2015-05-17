class Tripdetail < ActiveRecord::Base
  belongs_to :trip

  validates :name, presence: true,
  length: {
  minimum: 4,
  maximum: 50
  }

  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  validates :address, presence: true

  geocoded_by :address
  before_validation :geocode, :if => :address_changed?

end
