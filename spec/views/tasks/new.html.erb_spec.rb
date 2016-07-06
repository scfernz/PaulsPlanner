require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      :title => "MyString",
      :description => "MyText",
      :completed => false,
      :user => nil,
      :created_by => 1
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_title[name=?]", "task[title]"

      assert_select "textarea#task_description[name=?]", "task[description]"

      assert_select "input#task_completed[name=?]", "task[completed]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_created_by[name=?]", "task[created_by]"
    end
  end
end
