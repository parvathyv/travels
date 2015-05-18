class Photo < ActiveRecord::Base
  belongs_to :tripdetail

  validates :photo_name, presence: true

  validates :description, presence: true
  mount_uploader :photo_name, PhotoNameUploader
end
