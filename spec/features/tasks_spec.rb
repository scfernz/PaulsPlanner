require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  context "creating a task" do
    Steps "creating a task as a teacher" do
      When "I am an approved teacher and logged in" do
        first_teacher = User.new
        first_teacher.email = 'teacher1@admin.com'
        first_teacher.password = 'admin1'
        first_teacher.password_confirmation = 'admin1'
        first_teacher.save!
        first_teacher.remove_role :provisional
        first_teacher.add_role :teacher
        visit '/'
        click_link "Login"
        fill_in "user[email]", with: "teacher1@admin.com"
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
      end
      And "students exist in the database" do
        first_student = User.new
        first_student.email = 'test@student.com'
        first_student.name = 'David'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student
      end
      Then "I can create a task and assign it to a student" do
        click_link 'Tasks'
        click_link 'New Task'
        fill_in "task[title]", with: 'testtask'
        fill_in "task[description]", with: 'do this'
        select "David", :from => "task[user_id]"
        click_button 'Create Task'
      end
      And 'I can delete a task that I have assigned' do
        visit '/tasks'
        expect(page).to have_content 'testtask'
        click_link 'Delete'
        visit '/tasks'
        expect(page).to_not have_content 'testtask'
      end
    end
  end

  context "completing a task" do
    Steps "completing a task from profile page" do
      When "I am logged in as a student and I have a task" do
        first_student = User.new
        first_student.email = 'test@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        student1_task = Task.new
        student1_task.user_id = first_student.id
        student1_task.title = "taskone"
        student1_task.save!

        visit '/'
        click_link "Login"
        fill_in "user[email]", with: "test@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then "I can complete that task by clicking on a button on my profile page" do
        click_button "Complete"
        click_link "taskone"
        expect(page).to have_content "true"
      end
    end

    Steps "completing a task from the task show page" do
      When "I am logged in as a student and I have a task" do
        first_student = User.new
        first_student.email = 'test@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        student1_task = Task.new
        student1_task.user_id = first_student.id
        student1_task.title = "taskone"
        student1_task.save!

        visit '/'
        click_link "Login"
        fill_in "user[email]", with: "test@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then "I can complete that task by clicking on a button on the task page" do
        click_link "taskone"
        click_button "Complete"
        expect(page).to have_content "true"
      end
    end

  end
end
