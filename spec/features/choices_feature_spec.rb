require 'rails_helper'

describe 'Choices Features' do
  let(:user){ create :user}
  let(:event){ create :event, user: user }
  let(:user_two){ create :user_two }

  before :each do
    sign_in_as(event.user)
    @question = create(:question, event: event)
  end

  it 'can be created on a question' do
    visit("/events/#{event.id}")
    click_on "#{@question.content}"
    click_on 'Add New Choice'
    expect(page).to have_content "Event: #{event.title}"
    expect(page).to have_content "Question: #{@question.content}"
    fill_in "choice[content]", with: "Yes"
    click_on "Add Choice"
    expect(current_path).to eq question_path(@question.id)
    expect(page).to have_content "Choice successfully created"
    expect(page).to have_content "#{@question.choices.last.content}"
  end

  it "can only be created by events author" do
    create :choice, question: @question
    click_on "Sign out"
    sign_in_as(user_two)
    visit new_question_choice_path(@question)
    expect(page).to have_content('Sorry, but we were unable to serve your request.')
  end

  it "cannot be created by not logged in user" do
    click_on "Sign out"
    visit new_question_choice_path(@question)
    expect(current_path).to eq root_path
    expect(page).to have_content('Sorry, but we were unable to serve your request.')
  end

  it 'can be deleted' do
    question = create :question, event: event
    choice = create :choice, question: question
    visit question_path(question)
    click_on 'Delete Choice'
    expect(current_path).to eq question_path(question)
    expect(page).not_to have_content "#{choice.content}"
    expect(page).to have_content "Choice successfully deleted"
  end

  it 'can only be deleted by choice owner' do
    choice = create :choice, question: @question
    click_on 'Sign out'
    sign_in_as(user_two)
    page.driver.submit :delete, "/choices/#{choice.id}", {}
    expect(current_path).to eq root_path
    expect(page).to have_content "Sorry, but we were unable to serve your request."
  end
end
