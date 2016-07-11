class UserController < ApplicationController

  def index
    @user = current_user
    if current_user.nil?
      redirect_to '/users/sign_in'
    else
      @tasks = Task.where(user: current_user)
      # @meetings = Meeting.where(user: current_user)
    end
  end

  def approve_account
    approved_user = User.find(params[:approved_id])
    approved_user.remove_role :provisional
    approved_user.add_role :teacher
    redirect_to '/'
  end

  def update_picture
    @user = current_user
    @user.update(user_params)
    @user.save
    redirect_to '/' #page goes here
 end

private

 def user_params
   params.require(:user).permit(:image)
 end

end
