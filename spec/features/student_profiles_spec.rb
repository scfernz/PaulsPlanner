require 'rails_helper'

RSpec.feature "StudentProfiles", type: :feature do
  context 'seeing a student profile page' do
    Steps 'seeing a student profile page' do
      Given 'that I am a student and I have tasks' do
        first_student = User.new
        first_student.email = 'studentone@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        second_student = User.new
        second_student.email = 'studenttwo@student.com'
        second_student.password = '123456'
        second_student.password_confirmation = '123456'
        second_student.save!
        second_student.remove_role :provisional
        second_student.add_role :student

        student1_task = Task.new
        student1_task.user_id = first_student.id
        student1_task.title = "taskone"
        student1_task.save!

        student2_task = Task.new
        student2_task.user_id = second_student.id
        student2_task.title = "tasktwo"
        student2_task.save!
      end
      And 'I have logged in' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'studentone@student.com'
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then 'I can see my information' do
        expect(page).to have_content 'studentone@student.com'
      end
      And 'I can see my tasks' do
        expect(page).to have_content 'taskone'
      end
      And "I can't see other users' tasks" do
        expect(page).to_not have_content 'tasktwo'
      end
    end

    Steps "Seeing my tasks in chronological order" do
      Given "that I am a student and have multiple tasks" do
        first_student = User.new
        first_student.email = 'studentone@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student
        student1_task = Task.new
        student1_task.user_id = first_student.id
        student1_task.title = "taskone"
        student1_task.save!
        student2_task = Task.new
        student2_task.user_id = first_student.id
        student2_task.title = "tasktwo"
        student2_task.save!
        expect(student1_task.created_at).to be < student2_task.created_at
      end
      And 'I have logged in' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'studentone@student.com'
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then "my tasks are listed in chronological in the order of when they were created" do
        visit '/'
        expect(page).to have_content "taskone tasktwo"
      end
    end
  end
end
