require 'rails_helper'

RSpec.describe QuestionsController do
  include Capybara::DSL

  describe '#publish_question' do
    it 'fires pusher' do
      user = create(:user)
      event = create(:event, title: "Test Event", user: user)
      question = Question.create(content: "Test question", event: event)
      sign_in_as(user)
      visit event_path(event)
      click_on 'Publish'

      create(:choice, question: question)
      create(:choice, content: 'No', question: question)

      # p = QuestionsController.new
      # # expect(p).to receive(:publish_question)
      # expect(p.publish_question).to eq "Hello"
    end
  end

    def sign_in_as(user)
    visit root_path
    click_link 'Sign in'
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log in'
  end
end