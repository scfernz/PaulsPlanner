require 'rails_helper'

RSpec.feature "LoginLogouts", type: :feature do
  context "Logging into and out of the website" do
    Steps "Logging in and out" do
      When "I register with an account" do
        visit '/'
        click_link('Teachers')
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
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
        click_link "Login"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_content "teacher@teacher.edu"
        expect(page).to have_content "Signed in successfully."
      end
    end
  end
end
