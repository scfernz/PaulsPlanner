class Cohort < ActiveRecord::Base
  has_many :users
  resourcify # add this line
end
