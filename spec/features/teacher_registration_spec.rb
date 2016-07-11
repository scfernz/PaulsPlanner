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
end
