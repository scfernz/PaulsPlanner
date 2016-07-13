require 'rails_helper'
require 'testing_methods'

RSpec.feature "CohortTasks", type: :feature do
  context 'Assigning a task to a whole class' do
    Steps 'Assigning a task as a teacher' do
      When 'I am a registered teacher and a class exists with students in it' do
        generate_teacher('testteacher@teacher.com')
        login_teacher('testteacher@teacher.com')
        test_cohort_id = generate_cohort('2016 Test')
        test_student_id = generate_student('studentone@test.com')
        add_member_to_cohort(test_student_id, test_cohort_id)
        test_student_id = generate_student('studenttwo@test.com')
        add_member_to_cohort(test_student_id, test_cohort_id)
        test_student_id = generate_student('studentthree@test.com')
        add_member_to_cohort(test_student_id, test_cohort_id)
      end
      Then 'I can create a task for the whole class' do
        create_cohort_task_through_ui('testtask', 'this', '2016 Test')
      end
      And 'I can see those tasks in the task index' do
        visit '/tasks'
        expect(page).to have_content 'testtask'
      end
    end

    Steps 'Assigning a task without a title' do
      When 'I am a registered teacher and a class exists with students in it' do
        generate_teacher('testteacher@teacher.com')
        login_teacher('testteacher@teacher.com')
        test_cohort_id = generate_cohort('2016 Test')
        test_student_id = generate_student('studentone@test.com')
        add_member_to_cohort(test_student_id, test_cohort_id)
        test_student_id = generate_student('studenttwo@test.com')
        add_member_to_cohort(test_student_id, test_cohort_id)
        test_student_id = generate_student('studentthree@test.com')
        add_member_to_cohort(test_student_id, test_cohort_id)
      end
      Then 'I can create a task for the whole class without' do
        create_cohort_task_through_ui('', 'this', '2016 Test')
      end
      And 'I will see a warning message and the tasks will not exist' do
        expect(page).to have_content 'Tasks must have a title'
        visit '/tasks'
        expect(page).to_not have_content 'testtask'
      end
    end
  end
end
