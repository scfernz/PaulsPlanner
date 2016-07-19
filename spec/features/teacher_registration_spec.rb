require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context "Registering as a teacher" do
    Steps "Registering" do
      When "I visit the registration page" do
        visit "/users/sign_up"
      end
      Then "I can enter information into the registration fields" do
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        fill_in "user[name]", with: "Mr. Teacher"
        click_button "Sign up"
      end
      And "I am taken to my profile" do
        expect(page).to have_content "teacher@teacher.edu"
        expect(page).to have_content "Mr. Teacher"
      end
      And "A teacher admin can see all provisional accounts" do
        click_link "Logout"
        click_link "Login"
        fill_in "user[email]", with: "admin@admin.com"
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
        click_link('Provisional Accounts (1)')
        expect(page).to have_content "teacher@teacher.edu"
      end
      And "A teacher can convert a provisional account to a teacher account" do
        click_button "Approve"
        expect(page).to_not have_content "teacher@teacher.edu"
        click_link "Logout"
      end

      Given "I am a registered user" do
        visit "/users/sign_in"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
        expect(page).to have_content "Mr. Teacher's Profile"
      end
      And "I can edit my personal details on the Edit Page" do
        click_link "Edit Profile"
        expect(page).to have_content "Edit User"
        fill_in "user[name]", with: "Mr. Happy"
        fill_in "user[current_password]", with: "123456"
        click_button "change_button"
        expect(page).to have_content "Mr. Happy"
        #pending
      end

    end
  end
end
