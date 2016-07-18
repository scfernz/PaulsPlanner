class Meeting < ActiveRecord::Base
  has_and_belongs_to_many :users
  after_initialize :set_not_cancelled
  validates :title, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode
  resourcify # add this line

  def set_not_cancelled
    if self.cancelled.nil?
      self.cancelled = false
    end
  end
end
