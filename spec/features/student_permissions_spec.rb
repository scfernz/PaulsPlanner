require 'rails_helper'

RSpec.feature "StudentPermissions", type: :feature do
  context "Logging in as a student and visiting the cohort page" do
    Steps "Logging in and going to cohort page" do
      Given "That I am a student and have logged in" do
        first_student = User.new
        first_student.email = 'studentone@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.name = 'Arnold'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        visit "/"
        click_link "Login"
        fill_in "user[email]", with: "studentone@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then "I have no access to the cohorts page" do
        visit "/cohorts"
        expect(page).to have_content('You are not authorized to access this page.')
      end
    end
  end
end
