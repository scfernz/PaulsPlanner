require 'rails_helper'

RSpec.feature "StudentRegistrations", type: :feature do
  context "Registering with Facebook" do
    Steps "Registering with Facebook" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I see a link to sign up with Facebook" do
        expect(page).to have_content "Students: Sign in with Facebook"
      end
      And "I click on that link" do
        click_link('Sign in with Facebook')
      end
      Then "I see the success page" do
        expect(page).to have_content "Success!"
      end
    end
  end
end
