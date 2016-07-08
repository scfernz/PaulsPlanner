require 'rails_helper'

RSpec.feature "StudentRegistrations", type: :feature do
  context "Registering with Facebook" do
    Steps "Registering with Facebook" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I see a link to sign up with Facebook" do
        # TODO: fix this
        # expect(page).to have_content "Students: Sign in with Facebook"
      end
      # TODO: Implement tests to check that Facebook authentication actually works
      # And "I click on that link" do
      #   pending
      # end
      # Then "I see my profile" do
      #   pending
      # end
    end
  end
end
