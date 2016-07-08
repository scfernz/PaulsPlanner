class LandingController < ApplicationController
  def index
    #if the current user is logged in
    if !current_user.nil?
      redirect_to '/user/index'
    end
  end
end
