require 'rails_helper'
require 'testing_methods'

RSpec.feature "LoginLogouts", type: :feature do
  context "Logging into and out of the website" do
    Steps "Logging in and out" do
      When "I register with an account" do
        create_teacher_through_ui('teacher@teacher.edu')
        expect(page).to have_content "Welcome! You have signed up successfully."
      end
      Then "I can log out and I am taken to the landing page and I cannot see the login button" do
        expect(page).to_not have_content "Login"
        click_link "Logout"
        expect(page).to have_content "Signed out successfully."
        expect(page).to_not have_content "Logout"
        expect(page).to have_content "Welcome to Paul's Planner"
      end
      And "I can log in" do
        login_teacher('teacher@teacher.edu')
        expect(page).to have_content "teacher@teacher.edu"
        expect(page).to have_content "Signed in successfully."
      end
    end
  end
end
