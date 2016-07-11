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
    end
  end
  context "Editing Personal Details as a teacher" do
    Steps "Editing personal details" do
      Given "I am a registered user" do
        visit "/users/sign_up"
        fill_in "user[name]", with: "Mrs. Happy"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
        expect(page).to have_content "Mrs. Happy's Profile"
      end
      And "I can edit my personal details on the Edit Page" do
        click_link "Edit Profile"
        expect(page).to have_content "Edit User"
        fill_in "user[name]", with: "Mrs. Super Happy"
        fill_in "user[current_password]", with: "123456"
        click_button "Update"
      end
      Then "I see my updated profile page" do
        expect(page).to have_content "Mrs. Super Happy's Profile"
      end
    end
  end
end
