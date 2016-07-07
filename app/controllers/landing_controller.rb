class LandingController < ApplicationController
  def index
    #if the current user is logged in
    if !current_user.nil?
      render '/user/index.html.erb'
    end
  end
end
