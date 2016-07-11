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
        visit "cohorts/#{cohort_id}"
        expect(page).to have_content 'Students'
      end
      And 'I can add students to the cohort' do
        generate_student('student3@student.com')
        select('student3@student.com', :from => 'student_id')
        click_button "Add Student"
      end
    end
  end
end
