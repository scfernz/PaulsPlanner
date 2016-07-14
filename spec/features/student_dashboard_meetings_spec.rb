require 'rails_helper'

RSpec.feature "StudentDashboardMeetings", type: :feature do
  context 'Seeing meetings on the student profile page' do
    Steps 'seeing a student profile page' do
      Given 'I have logged in' do
        generate_student('student3@student.com')
        login_student('student3@student.com')
        generate_teacher('teacher@test.com')
      end
      Then 'I can see my information' do
        visit '/'
        expect(page).to have_content 'student3@student.com'
      end
      And "have created a meeting " do
        create_meeting_through_ui('San Diego', 'teacher@test.com')
        expect(page).to have_content("Meeting was successfully created")
      end
      Then 'I can see my meetings' do
        visit '/'
        expect(page).to have_link 'San Diego'
        expect(page).to have_content 'San Diego'
      end
    end
  end
end
