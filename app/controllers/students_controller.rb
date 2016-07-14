class StudentsController < ApplicationController

  def index
    @students = User.with_role(:student).order("LOWER(users.name)")
  end

end
