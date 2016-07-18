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
        fill_in "meeting[address]", with: "123 Main St"
        select('teacher@test.com', :from => 'teacher_id')
        select('2016', :from => 'meeting[date(1i)]')
        select('January', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
        click_link("New Meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[title]", with: "Second Meeting"
        fill_in "meeting[address]", with: "123 Main St"
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
        expect(page).to have_content("123 Main St")
      end
      And "I can see a list of only my upcoming meetings" do
        visit '/'
        expect(page).to have_content("Second Meeting")
        expect(page).to have_content("August 13 2016")
        expect(page).to_not have_content("January 13 2016")
      end
    end
    Steps "creating a meeting without a title or address" do
      Given "That I am a student and on the meeting page and there is a teacher" do
        generate_student('student@test.com')
        generate_teacher('teacher@test.com')
        login_student('student@test.com')
      end
      And "have created meetings that include teacher(s)" do
        click_link("New Meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[address]", with: ""
        select('teacher@test.com', :from => 'teacher_id')
        select('2017', :from => 'meeting[date(1i)]')
        select('January', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
      end
      Then "I see an error message" do
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Address can't be blank"
      end
    end
    Steps "creating a meeting with default address" do
      Given "That I am a student and on the meeting page and there is a teacher" do
        generate_student('student@test.com')
        generate_teacher('teacher@test.com')
        login_student('student@test.com')
      end
      And "have created meetings that include teacher(s)" do
        click_link("New Meeting")
        fill_in "meeting[title]", with: "First Meeting"
        fill_in "meeting[description]", with: "there"
        select('teacher@test.com', :from => 'teacher_id')
        select('2017', :from => 'meeting[date(1i)]')
        select('January', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
      end
      Then "The meeting will be created with the default address" do
        expect(page).to have_content "Address: 3803 Ray St, San Diego CA 92104"
      end
    end
  end

  context "I cannot create a meeting before the current date" do
    Steps "Schedule a meeting before today" do
      Given "That I am a student and on the meeting page and there is a teacher" do
        generate_student('student@test.com')
        generate_teacher('teacher@test.com')
        login_student('student@test.com')
      end
      And "have created a meeting before today" do
        click_link("New Meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[title]", with: "First Meeting"
        fill_in "meeting[address]", with: "123 Main St"
        select('teacher@test.com', :from => 'teacher_id')
        select('2016', :from => 'meeting[date(1i)]')
        select('July', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
        expect(page).to have_content 'You cannot create a meeting in the past.'
      end
    end
  end
end
