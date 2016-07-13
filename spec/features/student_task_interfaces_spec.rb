require 'rails_helper'
require 'testing_methods'

RSpec.feature "StudentTaskInterfaces", type: :feature do
  context "interacting with tasks as a student" do
    Steps "trying to access other student's tasks" do
      When "I am a registered student and logged in" do

        generate_student('test@student.com')
        second_student_id = generate_student('test2@student.com')
        teacher_id = generate_teacher('teacher@test.com')

        generate_task('test', 2, second_student_id, teacher_id)

        visit '/'
        click_link "Login"
        fill_in "user[email]", with: "test@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      And "I visit the url of a task for another student" do
        visit '/tasks/2'
      end
      Then "I am returned to my profile page with a security warning" do
        expect(page).to have_content 'You are not authorized'
      end
      When "I try to visit the task index list" do
        visit '/tasks'
      end
      Then "I am returned to my profile page with a security warning" do
        expect(page).to have_content 'You are not authorized'
      end
    end

    Steps "interacting with my own tasks" do
      Given "I am a registered student and logged in and I have a task" do
        first_student_id = generate_student('test@student.com')
        teacher_id = generate_teacher('teacher@test.com')

        generate_task('test', 1, first_student_id, teacher_id)

        visit '/'
        click_link "Login"
        fill_in "user[email]", with: "test@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      When "I visit a task's page" do
        visit '/'
        click_link "test"
      end
      Then "I do not see links to 'Edit' or 'Task List'" do
        expect(page).to_not have_content 'Task List'
      end
      And "I try to visit the task creation url" do
        visit '/tasks/new'
      end
      Then "I am returned to my profile page with a security warning" do
        expect(page).to have_content 'You are not authorized'
      end
      And "I try to visit the task edit url" do
        visit '/tasks/1/edit'
      end
      Then "I am returned to my profile page with a security warning" do
        expect(page).to have_content 'You are not authorized'
      end
    end

    Steps 'as a student, I can see a task' do
      When 'I am a student with tasks assigned by a teacher' do
        generate_teacher('teacher@test.com')
        generate_student('student@test.com')
        login_teacher('teacher@test.com')
        create_task_through_ui('taskone', 'stuff', 'student@test.com')
        click_link 'Logout'
        login_student('student@test.com')
      end
      Then 'I can see the details of that task and who assigned it' do
        visit '/'
        click_link 'taskone'
        expect(page).to have_content 'Assigned By: teacher@test.com'

      end
    end
  end
end
