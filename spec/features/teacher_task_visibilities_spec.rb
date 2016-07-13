require 'rails_helper'

RSpec.feature "TeacherTaskVisibilities", type: :feature do
  context "seeing tasks page" do
    Steps "registering as an approved teacher and visiting tasks" do
      When "I register as a teacher" do
        create_teacher_through_ui('teacher@teacher.edu')
      end
      Then "I cannot access the task index page" do
        visit '/tasks'
        expect(page).to have_content "You are not authorized to access this page."
        expect(page).to have_content "(provisional)"
        expect(page).to have_content "teacher@teacher.edu"
      end
      When "I am approved by another teacher" do
        click_link "Logout"

        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')

        click_link('Provisional Accounts (1)')
        click_button "Approve"
      end
      Then "I can access the student tasks page" do
        click_link "Logout"
        login_teacher('teacher@teacher.edu')
        visit '/tasks'
        expect(page).to have_content "Listing Tasks"
      end
    end

  end
end
