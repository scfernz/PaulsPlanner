class UserController < ApplicationController

  def index
    @user = current_user
    if current_user.nil?
      redirect_to '/users/sign_in'
    else
      if current_user.has_role?(:student)
        @tasks = Task.where(user: current_user).order(:created_at)
        @meetings = Meeting.where(created_by: current_user)
      elsif current_user.has_role?(:provisional)
        flash[:error] = "This teacher account must be approved by an admin."
      else
        @tasks = Task.where(user: current_user)
        today = DateTime.now
        @meetingstoday = []
        all_meetings = Meeting.all
        all_meetings.each do |meeting|
          if meeting.date.strftime('%Y-%m-%d') == Date.today.strftime
            @meetingstoday << meeting
          end
        end
      end
    end
  end

  # GET /user/1
  # GET /user/1.json
  def show
    @user = User.find(params[:id])
    if current_user.nil?
      flash[:alert] = 'You need to sign in or sign up before continuing.'
      redirect_to '/users/sign_in'
    elsif @user == current_user
      redirect_to '/user/index'
    elsif current_user.has_role? :teacher
      @tasks = Task.where(user: @user)
      @meetings = Meeting.where(created_by: @user)
    else
      flash[:alert] = 'You are not authorized to view this page.'
      redirect_to '/'
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
   params.require(:user).permit(:image, :name)
 end


end
