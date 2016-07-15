require 'rails_helper'
require 'testing_methods'

RSpec.feature "Cohort", type: :feature do
  context "Creating a cohort as a registered teacher" do
    Steps "registration and creating a cohort" do
      When 'I am a registed teacher and logged in' do
        generate_teacher('teacher@teacher.com')
        login_teacher('teacher@teacher.com')
      end
      Then 'I can see a list of cohorts' do
        visit '/cohorts'
        expect(page).to have_content 'Cohorts'
        expect(page).to_not have_content '2016 Bravo'
      end
      And 'I can create an empty cohort' do
        visit '/cohorts/new'
        fill_in 'cohort[name]', with: '2016 Bravo'
        click_button 'Create Cohort'
      end
      When 'I can see that cohort in the list of cohorts' do
        visit '/cohorts'
        expect(page).to have_content '2016 Bravo'
      end
      And 'I can add students to a cohort and then see them in the list' do
        cohort_id = generate_cohort('Alpha')
        generate_student('student3@student.com')
        generate_student('student@test.com')
        visit "cohorts/#{cohort_id}"
        select('student3@student.com', :from => 'member_id')
        click_button "Add Member"
        expect(page).to have_content 'Members student3@student.com'
      end
      And 'I can only add students who are not in cohorts already' do
        expect{select('student3@student.com', :from => 'member_id')}.to raise_error('Unable to find option "student3@student.com"')
        expect{select('teacher@teacher.com', :from => 'member_id')}.to raise_error('Unable to find option "teacher@teacher.com"')
      end
      Then 'I can also remove that student from the cohort' do
        click_button 'Remove'
        expect(page).to_not have_content 'Members student3@student.com Remove'
      end
      # if this is failing, make sure all seeded students belong to cohorts
      And 'If there are no students without cohorts, I see a message about it instead of the form' do
        select('student3@student.com', :from => 'member_id')
        click_button "Add Member"
        expect(page).to_not have_content 'There are no students without cohorts at this time.'
        select('student@test.com', :from => 'member_id')
        click_button "Add Member"
        # need to add seeded students to cohorts
        select('bane', :from => 'member_id')
        click_button "Add Member"
        select('batman', :from => 'member_id')
        click_button "Add Member"
        select('aaron', :from => 'member_id')
        click_button "Add Member"
        expect(page).to_not have_content 'Add Member'
        expect(page).to have_content 'There are no students without cohorts at this time.'
      end
    end
  end
end
