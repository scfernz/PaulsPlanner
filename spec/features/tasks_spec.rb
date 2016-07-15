require 'rails_helper'
require 'testing_methods'

RSpec.feature "Tasks", type: :feature do
  context "creating a task" do
    Steps "creating a task as a teacher" do
      When "I am an approved teacher and logged in" do
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
      end
      And "students exist in the database" do
        generate_student('student@test.com')
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
        click_button "Turn In"
      end
      And "The Turn In button will have disappeared" do
        expect{click_button "Turn In"}.to raise_error('Unable to find button "Turn In"')
      end
      And "The task page shows that the task has been Turn Ind and will also not have a 'Turn In' button" do
        click_link "taskone"
        expect(page).to have_content "true"
        expect{click_button "Turn In"}.to raise_error('Unable to find button "Turn In"')
      end
      And "I can log in as a teacher and see the status of the task" do
        click_link "Logout"
        login_teacher('teacher@test.com')
        click_link "Tasks"
        click_link "test@student.com"
        expect(page).to have_content 'Status'
        expect(page).to have_content  '✓'
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
end
