class UserController < ApplicationController

  def index
    @user = current_user
    if current_user.nil?
      redirect_to '/users/sign_in'
    else
      if current_user.has_role?(:student)
        @tasks = Task.where(user: current_user).order(:created_at)
        @meetings = Meeting.where(created_by: current_user)
      else
        @tasks = Task.where(user: current_user)
        @meetings = Meeting.all
      end
    end
  end

  def approve_account
    approved_user = User.find(params[:approved_id])
    approved_user.remove_role :provisional
    approved_user.add_role :teacher
    redirect_to '/'
  end

  def remove_from_cohort
    user_to_remove = User.find(params[:user][:id])
    user_to_remove.cohort_id = nil
    user_to_remove.save!
    flash[:notice] = 'Member removed from cohort.'
    redirect_to :back
  end

  def update_picture
    @user = current_user
    @user.update(user_params)
    @user.save
    redirect_to '/' #page goes here
 end

private

 def user_params
   params.require(:user).permit(:image, :name)
 end


end
