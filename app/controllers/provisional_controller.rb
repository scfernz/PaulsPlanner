class ProvisionalController < ApplicationController
  def index
    if !current_user.has_role? :teacher
      redirect_to '/'
      flash[:alert] = "You are not authorized to access this page."
    else
      render 'provisional/index'
    end
  end
end
