require 'rails_helper'

RSpec.feature "LoginLogouts", type: :feature do
  context "Logging into and out of the website" do
    Steps "Logging in and out" do
      When "I register with an account" do
        visit '/users/sign_up'
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
      end
      Then "I can log out and I am taken to the landing page and I cannot login button" do
        expect(page).to_not have_content "Login"
        click_link "Logout"
        expect(page).to_not have_content "Logout"
        expect(page).to have_content "Mission Statement"
      end
      And "I can log in" do
        click_link "Login"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_content "teacher@teacher.edu"
      end
    end
  end
end
