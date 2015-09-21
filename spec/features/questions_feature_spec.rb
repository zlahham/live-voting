require 'rails_helper'

describe 'Questions' do
  it 'can be created by a logged-in user' do
    visit root_path
    sign_up_user
    click_on 'Create Question'
    fill_in 'question', with: 'first question'
    click_on 'Create'
    expect(current_path).to eq root_path
    expect(page).to have_content "first question"
  end

  xit "cannot be created by a user that isn't logged in"

  def sign_up_user
    visit root_path
    click_on 'Sign up'
    fill_in 'email', with: "user@email.com"
    fill_in 'password', with: "password"
    fill_in 'password_confirmation', with: "password"
    click_on 'Sign up'
  end
end