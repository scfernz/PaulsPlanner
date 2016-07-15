class Meeting < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :title, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode
  resourcify # add this line
end
