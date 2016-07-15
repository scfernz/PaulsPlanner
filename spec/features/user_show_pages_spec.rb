require 'rails_helper'
require 'testing_methods'

RSpec.feature "UserShowPages", type: :feature do
  context 'Viewing a user profile page' do
    Steps 'I am on the landing page and I log in as a teacher' do
      Given 'I log in as a teacher' do
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
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

    Steps 'Trying to view a user profile as a student' do
      Given 'I am logged in as a student' do
        generate_student('student@test.com')
        login_student('student@test.com')
      end
      When 'I try to visit the profile page of a teacher' do
        teacher_id = generate_teacher('teacher@test.com')
        visit "/user/#{teacher_id}"
      end
      Then 'I am returned to my profile page with an authorization method' do
        expect(page).to have_content 'You are not authorized to'
        expect(page).to_not have_content "teacher@test.com's Profile"
        expect(page).to have_content "student@test.com's Profile"
      end
    end

    Steps 'Trying to view a user profile as a provisional user' do
      Given 'I am logged in as a student' do
        create_teacher_through_ui('provisional@test.com')
      end
      When 'I try to visit the profile page of a teacher' do
        teacher_id = generate_teacher('teacher@test.com')
        visit "/user/#{teacher_id}"
      end
      Then 'I am returned to my profile page with an authorization method' do
        expect(page).to have_content 'You are not authorized to'
        expect(page).to_not have_content "teacher@test.com's Profile"
        expect(page).to have_content "provisional@test.com's Profile"
      end
    end

    Steps 'Trying to view a profile as an unregistered user' do
      Given 'I am not logged in and I try to view a profile page' do
        someone_id = generate_teacher('someone@test.com')
        visit "user/#{someone_id}"
      end
      Then 'I am redirected_to the log in page' do
        expect(page).to have_content 'Log in Email Password'
      end
    end

    Steps 'Trying to view my own profile' do
      Given 'I am logged in as a student and I try to view my profile page' do
        student_id = generate_student('student@test.com')
        login_student('student@test.com')
        visit "/user/#{student_id}"
      end
      Then 'I am taken my actual profile' do
        expect(current_url).to include '/user/index'
      end
      Given 'I am logged in as a teacher and I try to view my profile page' do
        click_link 'Logout'
        teacher_id = generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
        visit "/user/#{teacher_id}"
      end
      Then 'I am taken my actual profile' do
        expect(current_url).to include '/user/index'
      end
    end
  end
end
