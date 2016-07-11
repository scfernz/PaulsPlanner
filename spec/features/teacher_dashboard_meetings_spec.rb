require 'rails_helper'

RSpec.feature "TeacherDashboardMeetings", type: :feature do
  context 'Seeing meetings on the student profile page' do
    Steps 'seeing a student profile page' do
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
      And "have created a meeting and logged out" do
        click_link('Meetings')
        expect(page).to have_content("Listing Meetings")
        click_link("New Meeting")
        fill_in "meeting[location]", with: "San Diego"
        fill_in "meeting[description]", with: "there"
        click_button "Create Meeting"
        expect(page).to have_content("Meeting was successfully created")
        click_link('Logout')
      end



      Then 'I have logged in as a teacher' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'admin@admin.com'
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
      end
      Then 'I can see my information' do
        visit '/'
        expect(page).to have_content 'admin@admin.com'
      end
      And 'I can see a list of all my meetings' do
        click_link('Profile')
        expect(page).to have_content  'My Meetings'
      end
      Then 'I can see my meetings' do
        visit '/'
        expect(page).to have_content 'San Diego'
      end
    end
  end
end
