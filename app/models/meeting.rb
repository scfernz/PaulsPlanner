class Meeting < ActiveRecord::Base
  has_many :users, through: :user_meetings

end
