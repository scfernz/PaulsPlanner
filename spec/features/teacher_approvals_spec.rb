require 'rails_helper'

RSpec.feature "TeacherApprovals", type: :feature do
  context "registering with teacher approval" do
    Steps "registration and approval" do
      When "I register with an email" do
        visit "/users/sign_up"
        fill_in "user[email]", with: "teacher@teacher.edu"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        click_button "Sign up"
      end
      Then "I am considered a provisional user" do
        expect(page).to have_content "(provisional)"
      end
      And "A teacher admin can see all provisional accounts" do
        click_link "Logout"
        click_link "Login"
        fill_in "user[email]", with: "admin@admin.com"
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
        expect(page).to have_content "teacher@teacher.edu"
      end
      And "A teacher can convert a provisional account to a teacher account" do
        click_button "Approve"
        expect(page).to_not have_content "teacher@teacher.edu"
      end
    end
  end
end
