class Task < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_incomplete

  def set_incomplete
    self.completed = false if self.completed.nil?
  end
end
