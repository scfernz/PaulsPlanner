class LandingController < ApplicationController
  def index
    #if the current user is logged in
    if !current_user.nil?
      render '/teacher_interface/index.html.erb'
    end
  end
end
