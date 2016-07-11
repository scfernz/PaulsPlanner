module TestingMethods
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
end

RSpec.configure do |c|
  c.include TestingMethods, type: :feature
end
