require "rails_helper"

RSpec.describe User, :type => :model do
  it "has a name" do
    user = User.new
    user.name = "Mr. Teacher"
    user.email = "teacher3@teacher.com"
    user.password = "teacher"
    user.password_confirmation = "teacher"
    user.save
    expect(User.last.name).to eq "Mr. Teacher"
  end
end
