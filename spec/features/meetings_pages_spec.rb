require 'rails_helper'

RSpec.feature "MeetingsPages", type: :feature do
  context 'I can see the meetings I am associated with on the meetings page' do
    Steps 'I have a list of all the meetings i am a part of' do
      Given 'I have logged in as a student' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'student1@student.com'
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      Then 'I can see my information' do
        visit '/'
        expect(page).to have_content 'student1@student.com'
      end
      And "have created a meeting " do
        click_link('Meetings')
        expect(page).to have_content("Listing Meetings")
        click_link("New Meeting")
        fill_in "meeting[location]", with: "San Diego"
        fill_in "meeting[description]", with: "there"
        click_button "Create Meeting"
        expect(page).to have_content("Meeting was successfully created")
      end
      Then 'view my meetings page' do
        click_link('Meetings')
        expect(page).to have_content 'San Diego'
      end
      Then 'I can log in as a teacher' do
        click_link('Logout')
        visit '/users/sign_in'
        fill_in "user[email]", with: 'admin@admin.com'
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
      end
      And 'I can see my information' do
        visit '/'
        expect(page).to have_content 'admin@admin.com'
      end
      Then 'I can go view my meetings page' do
        click_link('Meetings')
        expect(page).to have_content 'San Diego'
      end
    end
  end
end
