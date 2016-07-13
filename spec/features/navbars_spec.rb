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
        visit '/'
        click_link("Login")
        fill_in "user[email]", with: 'student1@student.com'
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_content 'student1@student.com'
        expect(page).to have_content 'New Meeting'
        expect(page).to have_content 'Logout'
        expect(page).to_not have_content 'Cohorts'
        click_link('Logout')
      end
      Then 'I can log in as a teacher and the links change' do
        visit '/'
        click_link("Login")
        fill_in "user[email]", with: 'admin@admin.com'
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
        expect(page).to have_content 'admin@admin.com'
        expect(page).to have_content 'Profile'
        expect(page).to have_content 'Tasks'
        expect(page).to have_content 'Meetings'
        expect(page).to have_content 'Cohorts'
        expect(page).to_not have_content 'New Meeting'
        expect(page).to have_content 'Logout'
      end
    end
  end
end
