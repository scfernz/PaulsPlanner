require 'rails_helper'

RSpec.feature "Meetings", type: :feature do
  context "Schedule a meeting with teacher" do
    Steps "Schedule a meeting with teacher" do
      Given "That I am a student and on the meeting page and there is a teacher" do
        first_student = User.new
        first_student.email = 'studentone@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.name = 'Arnold'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        first_teacher = User.new
        first_teacher.email = 'teacher@teacher.com'
        first_teacher.password = '123456'
        first_teacher.password_confirmation = '123456'
        first_teacher.save!
        first_teacher.remove_role :provisional
        first_teacher.add_role :teacher

        visit "/"
        click_link "Login"
        fill_in "user[email]", with: "studentone@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"
      end
      And "have created meetings that include teacher(s)" do
        click_link("New Meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[title]", with: "First Meeting"
        select('Paul', :from => 'teacher_id')
        select('2016', :from => 'meeting[date(1i)]')
        select('January', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"
        click_link 'Back'
        click_link("navbar_meeting")
        fill_in "meeting[description]", with: "there"
        fill_in "meeting[title]", with: "Second Meeting"
        select('Paul', :from => 'teacher_id')
        select('2016', :from => 'meeting[date(1i)]')
        select('August', :from => 'meeting[date(2i)]')
        select('13', :from => 'meeting[date(3i)]')
        click_button "Create Meeting"

      end
      Then "I can see a page with the details of the meeting that I just created" do
        expect(page).to have_content("Description: there")
        expect(page).to have_content("Paul")
        expect(page).to have_content("Arnold")
        expect(page).to have_content("Created by: Arnold")
      end
      And "I can see a list of only my upcoming meetings" do
        visit '/meetings'
        expect(page).to have_content("there")
        expect(page).to have_content("Paul")
        expect(page).to have_content("Arnold")
        expect(page).to have_content("2016-08-13")
        expect(page).to_not have_content("2016-01-13")
      end
    end
  end
end
