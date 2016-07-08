require 'rails_helper'

RSpec.feature "StudentLogins", type: :feature do
  context "A user logging in as a student" do
    Steps "A user logging in as a student" do
      Given "I am a facebook account and am logged in" do
        visit "/"
        click_link("Students")
        fill_in "email", with: 'fmezqlp_carrieroson_1467998722@tfbnw.net'
        fill_in "pass", with: 'oxwiqj9fqf4'
        click_button("loginbutton")
      end
      Then "I can see my student profile" do
        expect(page).to have_content "Student"
      end
    end
  end
end
