require 'rails_helper'

RSpec.feature "EditProfileFields", type: :feature do
  context "I can't see the password fields in my edit profile page as a student" do
    Steps 'I am on the edit profile page' do
      Given 'I have logged in' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'student1@student.com'
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      When 'I go to my edit profile page' do
        click_link "Edit Profile"
      end
      Then 'I cannot see password fields' do
        expect(page).to_not have_content 'Password'
        expect(page).to_not have_content 'Password confirmation'
        expect(page).to_not have_content 'Current password'
      end
    end
  end
end
