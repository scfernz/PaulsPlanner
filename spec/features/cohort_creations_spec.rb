require 'rails_helper'
require 'testing_methods'

RSpec.feature "CohortCreations", type: :feature do
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
      And 'I can see all students in a cohort' do
        cohort_id = generate_cohort('Alpha')
        generate_student('student3@student.com')
        visit "cohorts/#{cohort_id}"
        expect(page).to have_content 'Members'
      end
      And 'I can add students to the cohort' do
        select('student3@student.com', :from => 'member_id')
        click_button "Add Member"
        expect(page).to have_content 'Members student3@student.com'
      end
      Then 'I can also remove that student from the cohort' do
        click_button 'Remove'
        expect(page).to_not have_content 'Members student3@student.com'
      end
    end
  end
end
