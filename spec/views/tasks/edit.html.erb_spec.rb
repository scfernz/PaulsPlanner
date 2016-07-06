require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :title => "MyString",
      :description => "MyText",
      :completed => false,
      :user => nil,
      :created_by => 1
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input#task_title[name=?]", "task[title]"

      assert_select "textarea#task_description[name=?]", "task[description]"

      assert_select "input#task_completed[name=?]", "task[completed]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_created_by[name=?]", "task[created_by]"
    end
  end
end
