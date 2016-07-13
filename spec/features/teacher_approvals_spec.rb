require 'rails_helper'

RSpec.feature "TeacherApprovals", type: :feature do
  context "registering with teacher approval" do
    Steps "registration and approval" do
      When "I register with an email" do
        create_teacher_through_ui('teacher@teacher.edu')
      end
      Then "I am considered a provisional user" do
        expect(page).to have_content "(provisional)"
      end
      And "A teacher admin can see all provisional accounts" do
        click_link "Logout"
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
        click_link('Provisional Accounts (1)')
        expect(page).to have_content "teacher@teacher.edu"
      end
      And "A teacher can convert a provisional account to a teacher account" do
        click_button "Approve"
        expect(page).to_not have_content "teacher@teacher.edu"
      end
    end

    Steps "provisional accounts not visible to provisional or student accounts" do
      When "Multiple teacher provisional accounts are registered" do
        create_teacher_through_ui('teacher@teacher.edu')
        click_link "Logout"
        create_teacher_through_ui('teacher@test.com')
        click_link "Logout"
        generate_student('student@test.com')
      end
      Then "a provisional account should not have access to the list of other provisional accounts" do
        login_teacher('teacher@test.com')
        visit '/provisional/index'
        expect(page).to have_content 'You are not authorized to access this page'
        expect(page).to have_content '(provisional)'
      end
      Then "a student account should not have access to the list of other provisional accounts" do
        click_link 'Logout'
        login_student('student@test.com')
        visit '/provisional/index'
        expect(page).to have_content 'You are not authorized to access this page'
        expect(page).to have_content '(student)'
      end
    end
  end
end
