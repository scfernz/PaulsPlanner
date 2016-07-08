require 'rails_helper'

RSpec.feature "Navbars", type: :feature do
  context 'Navigating the website with the navbar' do
    Steps 'Navigating the website with the navbar' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can see a navbar' do
        click_link("Paul's Planner")
        # TODO: fix this
        # expect(page).to have_content("Mission Statement")
      end
    end
  end
end
