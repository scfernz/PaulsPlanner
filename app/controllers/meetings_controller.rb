class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource # add this line

  # GET /meetings
  # GET /meetings.json
  def index
    @user = current_user
    if current_user.nil?
      redirect_to '/'
    else
      if current_user.has_role?(:student)
        @tasks = Task.where(user: current_user)
        @meetings = Meeting.where(created_by: current_user)
      else
        @tasks = Task.where(user: current_user)
        @meetings = Meeting.all
      end
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @user_createdby = User.find(@meeting.created_by)
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new

  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.created_by = current_user.id
    @meeting.users << current_user
    @meeting.users << User.find(params[:teacher_id])

    respond_to do |format|
      if @meeting.save && @meeting.date > DateTime.now
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      elsif @meeting.date <= DateTime.now
        format.html { redirect_to '/meetings/new', alert: 'You cannot create a meeting in the past' }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def map_markers
    @meeting = Meeting.find(params[:meeting_id])
    meeting_markers = Gmaps4rails.build_markers(@meeting) do |meeting, marker|
      marker.lat meeting.latitude
      marker.lng meeting.longitude
      marker.infowindow meeting.address
    end
    render json: meeting_markers.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:title, :date, :location, :description, :created_by, :address)
    end
end
