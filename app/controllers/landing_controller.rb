class LandingController < ApplicationController
  def index
    #if the current user is logged in
    if !current_user.nil?
      # if the current user has an email
      if !current_user.email.nil?
        render '/teacher_interface/index.html.erb'
      end
    end
  end
end
