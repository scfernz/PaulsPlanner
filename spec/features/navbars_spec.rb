require 'rails_helper'

RSpec.feature "Navbars", type: :feature do
  context 'Navigating the website with the navbar' do
    Steps 'Navigating the website with the navbar' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can see a navbar and the links work' do
        click_link("Paul's Planner")
        expect(page).to have_content("Welcome to Paul's Planner")
        click_link("Login")
        expect(page).to have_content("Log in")
        click_link("Paul's Planner")
        expect(page).to have_content("Welcome to Paul's Planner")
      end
      Then 'I can log in as a student and the links change' do
        generate_student('student@test.com')
        login_student('student@test.com')
        expect(page).to have_content 'student@test.com'
        expect(page).to have_content 'New Meeting'
        expect(page).to have_content 'Logout'
        expect(page).to_not have_content 'Cohorts'
        click_link('Logout')
      end
      Then 'I can log in as a teacher and the links change' do
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
        expect(page).to have_content 'teacher@test.com'
        expect(page).to have_content 'Profile'
        expect(page).to have_content 'Tasks'
        expect(page).to have_content 'Meetings'
        expect(page).to have_content 'Cohorts'
        expect(page).to have_content 'Students'
        expect(page).to_not have_content 'New Meeting'
        expect(page).to have_content 'Logout'
      end
    end
  end
end
