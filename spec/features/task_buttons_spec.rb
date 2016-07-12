require 'rails_helper'

RSpec.feature "TaskButtons", type: :feature do
  context 'I cannot see the task button when logged in as a student' do
    Steps 'seeing a student profile page' do
      Given 'I have logged in' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'student1@student.com'
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      When 'I am on the student profile page' do
        visit '/'
      end
      Then 'I cannot see the task button on the navbar' do
        expect(page).to_not have_link 'Tasks'
      end
      And 'I can log in as a teacher' do
        click_link('Logout')
        visit '/users/sign_in'
        fill_in "user[email]", with: 'admin@admin.com'
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
      end
      Then 'I can see the tasks button on the navbar' do
        expect(page).to have_link 'Tasks'
      end
    end
  end
end
