require 'rails_helper'
require 'testing_methods'

RSpec.feature "Meetings", type: :feature do
  context "Schedule a meeting with teacher" do
    Steps "Schedule a meeting with teacher" do
      Given "That I am a student and on the meeting page and there is a teacher" do
        generate_student('student@test.com')
        generate_teacher('teacher@test.com')
        login_student('student@test.com')
      end
      And "have created a meeting that includes a teacher" do
        create_meeting_through_ui('there', 'teacher@test.com')
      end
      Then "I can see a page with the details of the meeting that I just created" do
        expect(page).to have_content("Description: there")
        expect(page).to have_content("student@test.com")
        expect(page).to have_content("teacher@test.com")
        expect(page).to have_content("Created by: student@test.com")
      end
      And "I can see a list of all my meetings" do
        visit '/meetings'
        expect(page).to have_content("there")
        expect(page).to have_content("student@test.com")
        expect(page).to have_content("teacher@test.com")
      end
    end
  end
end
