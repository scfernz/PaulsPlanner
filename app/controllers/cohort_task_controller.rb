class CohortTaskController < ApplicationController  
  # GET /tasks/new_cohort_task
  def index
    if !current_user.nil? && current_user.has_role?(:teacher)
    else
      flash[:alert] = 'You are not authorized to view this page'
      redirect_to '/user/index'
    end
  end
end
