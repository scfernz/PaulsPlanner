require 'rails_helper'

RSpec.describe "meetings/show", type: :view do
  before(:each) do
    @meeting = assign(:meeting, Meeting.create!(
      :location => "Location",
      :description => "Description",
      :created_by => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
  end
end
