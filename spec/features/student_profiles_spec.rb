require 'rails_helper'

RSpec.feature "StudentProfiles", type: :feature do
  context 'seeing a student profile page' do
    Steps 'seeing a student profile page' do
      Given 'that I am a student and have logged in' do
        # visit '/studentlogin'
        #click button...
        # click_button('Login')
      end
      Then 'I can see my information' do
        # expect(page).to have_content('Welcome, Joe')
      end
    end
  end
end
