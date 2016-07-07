require 'rails_helper'

RSpec.describe "meetings/edit", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(
      :location => "MyString",
      :description => "MyString",
      :created_by => 1
    ))
  end

  it "renders the edit meeting form" do
    render

    assert_select "form[action=?][method=?]", meeting_path(@meeting), "post" do

      assert_select "input#meeting_location[name=?]", "meeting[location]"

      assert_select "input#meeting_description[name=?]", "meeting[description]"

      assert_select "input#meeting_created_by[name=?]", "meeting[created_by]"
    end
  end
end
