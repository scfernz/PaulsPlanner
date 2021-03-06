require 'rails_helper'

RSpec.feature "PictureUploads", type: :feature do
  context 'seeing a student profile page' do
    Steps 'seeing a student profile page' do
      Given 'I have logged in' do
        generate_teacher('teacher@test.com')
        login_teacher('teacher@test.com')
      end
      Then 'I can see a default picture' do
        expect(page).to have_xpath("//img[@src=\"/assets/default-profile-e08597880fc222202f22984a4f1966a29b108e856a3fb935072bfbbc302a4b73.png\"]")
      end
      Then 'I can upload a picture' do
        click_link 'Edit Profile'
        fill_in "user[current_password]", with: "123456"
        attach_file('user[image]', Rails.root + 'public/apple-icon.png')
        click_button 'Apply Changes'
      end
      # And 'I can see the image on my profile' do
      #   visit '/'
      #   expect(page).to have_xpath("//img[@alt='Apple icon']")
      # end
    end
  end
end
