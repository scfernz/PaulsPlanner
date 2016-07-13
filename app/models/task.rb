class Task < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_incomplete
  validates :title, presence: true

  def set_incomplete
    self.completed = false if self.completed.nil?
  end

  resourcify # add this line
end
