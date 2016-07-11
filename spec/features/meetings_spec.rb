require 'rails_helper'

RSpec.feature "Meetings", type: :feature do
  context "Schedule a meeting with teacher" do
    Steps "Schedule a meeting with teacher" do
      Given "That I am a student and on the meeting page" do
        first_student = User.new
        first_student.email = 'studentone@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student

        visit "/"
        click_link "Login"
        fill_in "user[email]", with: "studentone@student.com"
        fill_in "user[password]", with: "123456"
        click_button "Log in"

        click_link('Meetings')
        expect(page).to have_content("Listing Meetings")
      end
      And "have created a meeting " do
        click_link("New Meeting")
        fill_in "meeting[location]", with: "here"
        fill_in "meeting[description]", with: "there"
        click_button "Create Meeting"
        expect(page).to have_content("Meeting was successfully created")
      end
      Then "I can see all my meetings that includes the one I just created" do
        #see "meeting with <selected teacher>"
      end
    end
  end
end
