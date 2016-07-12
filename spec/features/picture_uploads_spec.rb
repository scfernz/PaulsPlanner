require 'rails_helper'

RSpec.feature "PictureUploads", type: :feature do
  context 'seeing a student profile page' do
    Steps 'seeing a student profile page' do
      Given 'that I am a student' do
        generate_student('studentone@student.com')
      end
      And 'I have logged in' do
        login_student('studentone@student.com')
      end
      Then 'I can see a default picture' do
        expect(page).to have_xpath("//img[@src=\"/assets/default-profile-e08597880fc222202f22984a4f1966a29b108e856a3fb935072bfbbc302a4b73.png\"]")
      end
      Then 'I can upload a picture' do
        attach_file('user[image]', Rails.root + 'public/apple-icon.png')
        click_button 'Update User'
      end
      And 'I can see the image on my profile' do
        visit '/'
        expect(page).to have_xpath("//img[@alt='Apple icon']")
      end
    end
  end
end
