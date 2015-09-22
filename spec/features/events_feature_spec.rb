require 'rails_helper'

describe 'Events', js: true do
  it 'can be created' do
    visit root_path
    sign_up_user
    click_on 'Create Event'
    
    fill_in 'event_title', with: 'event 1'
    click_on 'Add question'
    expect(page).to have_content 'event 1'
  end

  # it 'can be created by a user with one question' do

  #   fill_in 'Question', with: 'Ruby vs Javascript'
  #   fill_in 'Choice 1', with: 'Ruby'
  #   fill_in 'Choice 2', with: 'Javascript'
  #   click_on 'Publish'
  #   expect(page).to have_content 'Your event has been published'
  #   expect(page).to have_content 'LINK TO EVENT'
  # end

  def sign_up_user
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: "user@email.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_on 'Sign up'
  end
end
