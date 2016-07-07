require 'rails_helper'

RSpec.feature "Meetings", type: :feature do
  context "Schedule a meeting with teacher" do
    Steps "Schedule a meeting with teacher" do
      Given "That I am a student and on the meeting page" do
        #log in via social media...eventually
        first_student = User.new
        first_student.email = 'studentone@student.com'
        first_student.password = '123456'
        first_student.password_confirmation = '123456'
        first_student.save!
        first_student.remove_role :provisional
        first_student.add_role :student
        # click_link('Meetings')
        expect(page).to have_content("Listing Meetings")
      end
      And "have created a meeting" do
        #fill in location
        #fill in description
        #select in teacer
        #click_button "Create Meeting"
      end
      Then "I can see all my meetings that includes the one I just created" do
        #see "meeting with <selected teacher>"
      end
    end
  end
end
