require 'rails_helper'
require 'testing_methods'

RSpec.feature "MeetingsPages", type: :feature do
  context 'I can see the meetings I am associated with on the meetings page' do
    Steps 'I have a list of all the meetings i am a part of' do
      Given 'I have logged in as a student' do
        generate_student('student@test.com')
        login_student('student@test.com')
        generate_teacher('teacher@test.com')
      end
      Then 'I can see my information' do
        visit '/'
        expect(page).to have_content 'student@test.com'
      end
      And "have created a meeting " do
        create_meeting_through_ui('San Diego', 'teacher@test.com')
        expect(page).to have_content("Meeting was successfully created")
      end
      Then 'view my meetings page' do
        click_link('My Profile')
        expect(page).to have_content 'San Diego'
      end
      Then 'I can log in as a teacher' do
        click_link('Logout')
        login_teacher('teacher@test.com')
      end
      And 'I can see my information' do
        visit '/'
        expect(page).to have_content 'teacher@test.com'
      end
      Then 'I can go view my meetings page' do
        click_link('Meetings')
        expect(page).to have_content 'Upcoming Meetings'
      end
    end
  end

  context "viewing meetings as a teacher" do
    Steps "viewing meetings as a teacher" do
      Given "that I am a teacher and a student has created a meeting with me" do

        generate_teacher('teacher@test.com')
        generate_student('student@test.com')
        login_student('student@test.com')
        create_meeting_through_ui('here', 'teacher@test.com')
        click_link 'Logout'
        login_teacher('teacher@test.com')
        click_link 'Meetings'
        expect(page).to have_content 'student@test.com'
      end
      Then "I cannot edit or destroy the meeting" do
        expect(page).to have_content 'Edit Profile'
        expect(page).not_to have_content 'Edit Meeting'
      end

    end
  end
end
