require 'rails_helper'

describe 'Events' do
  it 'can be created' do
    visit root_path
    sign_up_user
    click_on 'Create Event'

    fill_in 'event_title', with: 'event 1'
    click_on 'Add question'
    expect(page).to have_content 'event 1'
  end

  def sign_up_user
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: "user@email.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_on 'Sign up'
  end
end
