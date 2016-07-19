require 'rails_helper'

RSpec.feature "StudentProfiles", type: :feature do
  context 'seeing a student profile page' do
    Steps 'seeing a student profile page' do
      Given 'that I am a student and I have tasks' do
        student_one_id = generate_student('studentone@student.com')
        student_two_id = generate_student('studenttwo@student.com')
        teacher_id = generate_teacher('teacher@test.com')
        generate_task('taskone', 1, student_one_id, teacher_id)
        generate_task('tasktwo', 2, student_two_id, teacher_id)
        cohort_id = generate_cohort('Cohort1')
        add_member_to_cohort(student_one_id, cohort_id)
      end
      And 'I have logged in' do
        login_student('studentone@student.com')
      end
      Then 'I can see my information' do
        expect(page).to have_content 'studentone@student.com'
      end
      And 'I can see my tasks' do
        expect(page).to have_content 'taskone'
      end
      And 'I can see my meetings' do
        expect(page).to have_content 'Upcoming Meetings'
      end
      And "I can't see other users' tasks" do
        expect(page).to_not have_content 'tasktwo'
      end
      And "I can see which cohort I am in" do
        expect(page).to have_content "Cohort1"
      end
      And "when I view that student's profile as a teacher" do
        click_link 'Logout'
        login_teacher('teacher@test.com')
        visit '/students/index'
        click_link 'studentone@student.com'
      end
      Then "I see that they do not have any meetings" do
        expect(page).to have_content 'studentone@student.com has no upcoming meetings.'
      end
    end

    Steps "Seeing my tasks in chronological order" do
      Given "that I am a student and have multiple tasks" do
        student_one_id = generate_student('studentone@student.com')
        teacher_id = generate_teacher('teacher@test.com')
        generate_task('taskone', 1, student_one_id, teacher_id)
        generate_task('tasktwo', 2, student_one_id, teacher_id)

        expect(Task.find(1).created_at).to be < Task.find(2).created_at
      end
      And 'I have logged in' do
        login_student('studentone@student.com')
      end
      Then "my tasks are listed in chronological in the order of when they were created" do
        visit '/'
        expect(page).to have_content "taskone tasktwo"
      end
    end
  end
end
