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
      And "have created meetings that include teacher(s)" do
        click_link("New Meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[title]", with: "First Meeting"
        select('teacher@test.com', :from => 'teacher_id')
        select('2016', :from => 'meeting[date(1i)]')
        select('January', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
        click_link 'Back'
        click_link("navbar_meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[title]", with: "Second Meeting"
        select('teacher@test.com', :from => 'teacher_id')
        select('2016', :from => 'meeting[date(1i)]')
        select('August', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
      end
      Then "I can see a page with the details of the meeting that I just created" do
        expect(page).to have_content("Description: there")
        expect(page).to have_content("student@test.com")
        expect(page).to have_content("teacher@test.com")
        expect(page).to have_content("Created by: student@test.com")
      end
      And "I can see a list of only my upcoming meetings" do
        visit '/meetings'
        expect(page).to have_content("there")
        expect(page).to have_content("teacher@test.com")
        expect(page).to have_content("student@test.com")
        expect(page).to have_content("2016-08-13")
        expect(page).to_not have_content("2016-01-13")
      end
    end
  end
end
