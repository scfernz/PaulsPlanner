require 'rails_helper'

RSpec.feature "Navbars", type: :feature do
  context 'Navigating the website with the navbar' do
    Steps 'Navigating the website with the navbar' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can see a navbar and the links work' do
        click_link("Paul's Planner")
        expect(page).to have_content("Welcome to Paul's Planner")
        click_link("Login")
        expect(page).to have_content("Log in")
        click_link("Paul's Planner")
        expect(page).to have_content("Welcome to Paul's Planner")
      end
    end
  end
end
