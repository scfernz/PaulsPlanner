require 'rails_helper'
require 'testing_methods'

RSpec.feature "UserShowPages", type: :feature do
  context 'I can see a user profile page' do
    Steps 'I am on the landing page and I log in as a teacher' do
      Given 'I log in as a teacher' do
        visit '/users/sign_in'
        fill_in "user[email]", with: 'admin@admin.com'
        fill_in "user[password]", with: "admin1"
        click_button "Log in"
      end
      Then 'I can go to the cohort page and click on a link to a student profile' do
        generate_cohort('2016b')
        add_member_to_cohort(User.find_by_email('student1@student.com').id, Cohort.find_by_name('2016b').id)
        click_link 'Cohorts'
        click_link 'Show'
        click_link 'bane'
        expect(page).to have_content "bane's Profile"
        expect(page).to have_content "Meetings"
        expect(page).to have_content "Tasks"
      end
    end
  end
end
