require 'rails_helper'
require 'testing_methods'

RSpec.feature "Tasks", type: :feature do
  context "creating a task" do
    Steps "creating a task as a teacher" do
      When "I am logged in as a student and do not have tasks" do
        generate_student('student@test.com')
        login_student('student@test.com')
      end
      Then "I have a message on my profile page indicating that I do not have tasks" do
        expect(page).to have_content 'You have no tasks.'
        click_link 'Logout'
      end
      When "I am an approved teacher and logged in" do
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
      end
      Then "I can create a task and assign it to a student" do
        create_task_through_ui('testtask', 'do this', 'student@test.com')
      end
      And "I can see the task I have assigned and name of the person I have assigned it to" do
        expect(page).to have_content "student@test.com"
      end
      And "I can view a list of all the tasks that I have assigned and names of students I have assigned them to" do
        click_link 'Task List'
        expect(page).to have_content "student@test.com"
      end
      And "I can visit the task's page and see 'Edit' and 'Task List' links" do
        visit '/tasks'
        expect(page).to have_content 'testtask'
        click_link 'testtask'
        expect(page).to have_content 'Delete'
        expect{click_link 'Edit'}.not_to raise_error
        expect{click_link 'Task List'}.not_to raise_error
      end
      And "I can click on a student's name and view their profile" do
        visit '/tasks'
        click_link 'student@test.com'
        expect(page).to have_content "student@test.com"
      end
      And 'I can delete a task that I have assigned' do
        visit '/tasks'
        click_link 'testtask'
        click_link 'Delete'
        expect(page).to_not have_content 'testtask'
      end
      And 'I cannot create a task without a title' do
        create_task_through_ui('', 'do this', 'student@test.com')
        expect(page).to have_content "Title can't be blank"
      end
    end
  end

  context "completing a task" do
    Steps "completing a task from profile page" do
      When "I am logged in as a student and I have a task" do
        generate_student('test@student.com')
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
        create_task_through_ui('taskone', 'description', 'test@student.com')
        click_link 'Logout'
        login_student('test@student.com')
      end
      Then "I can Turn In that task by clicking on a button on my profile page" do
        expect(page).to have_selector ".empty_check"
      end
      And "The Turn In button will have disappeared" do
        expect{click_button "□"}.to raise_error('Unable to find button "□"')
      end
      And "The task page shows that the task has been Turn In and will also not have a 'Turn In' button" do
        click_link "taskone"
        expect(page).to have_content "false"
        expect{click_button "Take Back"}.to raise_error('Unable to find button "Take Back"')
      end
      And "I can log in as a teacher and see the status of the task" do
        click_link "Logout"
        login_teacher('teacher@test.com')
        click_link "Tasks"
        click_link "test@student.com"
        expect(page).to have_content 'Status'
      end
    end

    Steps "completing a task from the task show page" do
      When "I am logged in as a student and I have a task" do
        generate_student('test@student.com')
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
        create_task_through_ui('taskone', 'description', 'test@student.com')
        click_link 'Logout'
        login_student('test@student.com')
      end
      Then "I can Turn In that task by clicking on a button on the task page" do
        click_link "taskone"
        click_button "Turn In"
        expect(page).to have_content "true"
      end
      And 'The Turn In button is replaced by a Take Back button' do
        click_button 'Take Back'
      end
      When 'I user the Take Back button, the task is considered incomplete' do
        expect(page).to have_content 'false'
      end
    end

  end
  context 'seeing a list of tasks' do
    Steps 'seeing tasks sorted by cohort' do
      Given 'I am signed in a a teacher'do
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
      end
      And 'There are students in different cohorts' do
        generate_student('student@test.com')
        generate_student('student2@test.com')
        generate_cohort('2016')
        generate_cohort('2017')
        add_member_to_cohort(User.find_by_email('student@test.com').id, Cohort.find_by_name('2016').id)
        add_member_to_cohort(User.find_by_email('student2@test.com').id, Cohort.find_by_name('2017').id)
      end
      And 'Each of those students has a task' do
        generate_task('task', 1, User.find_by_email('student@test.com').id, User.find_by_email('teacher@test.com').id)
        generate_task('another task', 2, User.find_by_email('student2@test.com').id, User.find_by_email('teacher@test.com').id)
      end
      Then 'I see the tasks sorted by cohort in reverse alphabetical order' do
        visit '/tasks'
        expect(page.find("//table/tbody/tr[1]/td[1]")).to have_content 'another task'
        expect(page.find("//table/tbody/tr[1]/td[4]")).to have_content 'student2@test.com'
        expect(page.find("//table/tbody/tr[1]/td[5]")).to have_content '2017'
        expect(page.find("//table/tbody/tr[2]/td[1]")).to have_content 'task'
        expect(page.find("//table/tbody/tr[2]/td[4]")).to have_content 'student@test.com'
        expect(page.find("//table/tbody/tr[2]/td[5]")).to have_content '2016'
      end
    end
  end
end
