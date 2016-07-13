module TestingMethods
  def generate_task(title, task_id, student_id)
    test_task = Task.new
    test_task.title = title
    # need to know id of task to test
    test_task.id = task_id
    test_task.user_id = student_id
    test_task.save!
  end

  def create_task_through_ui(title, description, student_name)
    click_link 'Tasks'
    click_link 'New Task'
    fill_in "task[title]", with: title
    fill_in "task[description]", with: description
    select student_name, :from => "task[user_id]"
    click_button 'Create Task'
  end

  def create_cohort_task_through_ui(title, description, cohort_name)
    visit '/cohort_task/index'
    fill_in 'title', with: title
    fill_in 'description', with: description
    select cohort_name, :from => 'cohort_id'
    click_button 'Assign Tasks'
  end

  def generate_student(email)
    new_student = User.new
    new_student.email = email
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
    newteacher.password = '123456'
    newteacher.password_confirmation = '123456'
    newteacher.save!
    newteacher.remove_role :provisional
    newteacher.add_role :teacher
    newteacher.id
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
