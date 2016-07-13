require 'rails_helper'
require 'testing_methods'

RSpec.feature "StudentTaskInterfaces", type: :feature do
  context "interacting with tasks as a student" do
    Steps "trying to access other student's tasks" do
      When "I am a registered student and logged in" do
        first_student = User.new
        first_student.email = 'test@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        second_student = User.new
        second_student.email = 'test2@student.com'
        second_student.password = '123456'
        second_student.password_confirmation = '123456'
        second_student.save!
        second_student.remove_role :provisional
        second_student.add_role :student

        generate_task('test', 2, second_student.id)

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
        first_student = User.new
        first_student.email = 'test@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        generate_task('test', 1, first_student.id)

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
        expect{click_link 'Edit'}.to raise_error('Unable to find link "Edit"')
        expect{click_link 'Task List'}.to raise_error('Unable to find link "Task List"')
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
  end
end
