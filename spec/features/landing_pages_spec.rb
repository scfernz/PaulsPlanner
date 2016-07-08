require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'visiting the website for the first time' do
    Steps 'visiting the website' do
      When 'I visit the website for the first time' do
        visit '/'
        expect(page).to have_content("Welcome to Paul's Planner")
        # TODO: fix this
        # expect(page).to have_content("Mission Statement")
      end
    end
  end
end
