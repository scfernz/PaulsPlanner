require 'rails_helper'

RSpec.describe "meetings/new", type: :view do
  before(:each) do
    assign(:meeting, Meeting.new(
      :location => "MyString",
      :description => "MyString",
      :created_by => 1
    ))
  end

  it "renders new meeting form" do
    render

    assert_select "form[action=?][method=?]", meetings_path, "post" do

      assert_select "input#meeting_location[name=?]", "meeting[location]"

      assert_select "input#meeting_description[name=?]", "meeting[description]"

      assert_select "input#meeting_created_by[name=?]", "meeting[created_by]"
    end
  end
end
