require 'rails_helper'

RSpec.feature "TeacherTaskVisibilities", type: :feature do
  context "seeing tasks page" do
    Steps "registering as an approved teacher and visiting tasks" do
      When "I register as a teacher" do
        visit "/users/sign_up"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
      end
      Then "I cannot access the task index page" do
        visit '/tasks'
        expect(page).to have_content "Profile"
        expect(page).to have_content "teacher@teacher.edu"
      end
      When "I am approved by another teacher" do
        click_link "Logout"
        click_link "Login"
        fill_in "user[email]", with: "admin@admin.com"
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
        click_link('Provisional Accounts (1)')
        click_button "Approve"
      end
      Then "I can access the student tasks page" do
        click_link "Logout"
        click_link "Login"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        visit '/tasks'
        expect(page).to have_content "Listing Tasks"
      end
    end

  end
end
