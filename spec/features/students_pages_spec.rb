require 'rails_helper'
require 'testing_methods'

RSpec.feature "StudentsPages", type: :feature do
  context "as a teacher, I can see a list of students" do
    Steps "as a teacher, I can see a list of students" do
      Given "I am a teacher, there are students in cohorts, and I am logged in" do
        # using users created in seeds.rb, should drop db and seed
        visit '/'
        click_link('Login')
        fill_in "user[email]", with: 'admin@admin.com'
        fill_in "user[password]", with: 'admin1'
        click_button "Log in"
        cohort1 = generate_cohort('Cohort1')
        cohort2 = generate_cohort('Cohort2')
        add_member_to_cohort(2, cohort1)
        add_member_to_cohort(3, cohort2)
        # not adding third_student in seeds.rb to any cohort
      end
      Then "I can go to a students page" do
        click_link 'Students'
        expect(page).to have_content 'Listing Students'
      end
      And "see all the registered students" do
        expect(page).to have_content 'bane'
        expect(page).to have_content 'batman'
        expect(page).to have_content 'aaron'
      end
      And "I can see what cohorts the students belong to" do
        expect(page).to have_content 'bane Cohort1'
        expect(page).to have_content 'batman Cohort2'
        # puts page.find("//table/tbody/tr[1]/td[1]").text
        expect(page.find("//table/tbody/tr[3]/td[1]")).to have_content 'aaron'
        expect(page.find("//table/tbody/tr[3]/td[2]")).to have_content ''
      end
    end
  end
end
