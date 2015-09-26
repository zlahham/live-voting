require 'rails_helper'

describe 'Choices Features' do
  let(:event){ create :event, user: create(:user) }

  before :each do
    sign_in_as(event.user)
    @question = create(:question, event: event)
  end

  it 'can be created on a question' do
    visit("/events/#{event.id}")
    click_on "#{@question.content}"
    click_on 'Add Choice'
    fill_in 'choice[content]', with: "Yes"
    click_on 'Add Choice'
    expect(current_path).to eq question_path(@question.id)
    expect(page).to have_content "Choice successfully created"
    expect(page).to have_content "#{@question.choices.last.content}"
  end
end