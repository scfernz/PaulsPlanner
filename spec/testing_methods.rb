module TestingMethods
  def generate_task(title, task_id, student_id, teacher_id)
    test_task = Task.new
    test_task.title = title
    test_task.createdby_id = teacher_id
    # need to know id of task to test
    test_task.id = task_id
    test_task.user_id = student_id
    test_task.save!
  end

  def create_task_through_ui(title, description, student_name)
    click_link 'Tasks'
    click_link 'Assign a task to a student'
    fill_in "task[title]", with: title
    fill_in "task[description]", with: description
    select student_name, :from => "task[user_id]"
    click_button 'Create Task'
  end

  def create_meeting_through_ui(description, teacher_name)
    click_link("New Meeting")
    fill_in "meeting[description]", with: description
    select teacher_name, :from => 'teacher_id'
    click_button "Create Meeting"
  end

  def create_cohort_task_through_ui(title, description, cohort_name)
    visit '/cohort_task'
    fill_in 'title', with: title
    fill_in 'description', with: description
    select cohort_name, :from => 'cohort_id'
    click_button 'Assign Tasks'
  end

  def generate_student(email)
    new_student = User.new
    new_student.email = email
    # TODO: change all tests using generate_student method to actually need name
    new_student.name = email
    new_student.password = '123456'
    new_student.password_confirmation = '123456'
    new_student.save!
    new_student.remove_role :provisional
    new_student.add_role :student
    new_student.id
  end

  def login_student(email)
    visit '/'
    click_link('Login')
    fill_in "user[email]", with: email
    fill_in "user[password]", with: '123456'
    click_button "Log in"
  end

  def generate_teacher(email)
    newteacher = User.new
    newteacher.email = email
    newteacher.name = email
    newteacher.password = '123456'
    newteacher.password_confirmation = '123456'
    newteacher.save!
    newteacher.remove_role :provisional
    newteacher.add_role :teacher
    newteacher.id
  end

  def create_teacher_through_ui(email)
    visit "/"
    click_link("Teachers")
    click_link("Sign up")
    fill_in 'user[name]', with: email
    fill_in "user[email]", with: email
    fill_in "user[password]", with: "123456"
    fill_in "user[password_confirmation]", with: "123456"
    click_button "Sign up"
  end

  def login_teacher(email)
    visit '/'
    click_link('Login')
    fill_in "user[email]", with: email
    fill_in "user[password]", with: '123456'
    click_button "Log in"
  end

  def generate_cohort(name)
    new_cohort = Cohort.new
    new_cohort.name = name
    new_cohort.save!
    new_cohort.id
  end

  def add_member_to_cohort(user_id, cohort_id)
    user_to_add = User.find(user_id)
    user_to_add.cohort_id = cohort_id
    user_to_add.save!
  end
end

RSpec.configure do |c|
  c.include TestingMethods, type: :feature
end
