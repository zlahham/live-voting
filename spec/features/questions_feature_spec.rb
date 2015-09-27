require 'rails_helper'

describe 'Questions Features' do
  let(:event){ create :event, user: create(:user) }

  before :each do
    sign_in_as(event.user)
  end

  it 'can be created on an event' do
    visit event_path(event)
    click_on 'Add Question'
    fill_in 'question_content', with: 'test question'
    click_on 'Add'
    expect(page).to have_content 'Question successfully created'
    expect(page).to have_content 'test question'
  end

  it "can't be created with a blank content field" do
    visit event_path(event)
    click_on 'Add Question'
    click_on 'Add'
    expect(page).to have_content "1 error prohibited this question from being saved:"
  end

  it 'can be deleted' do
    question = create :question, event: event
    visit event_path event
    expect(page).to have_content "#{question.content}"
    click_on 'Delete Question'
    expect(page).not_to have_content "#{question.content}"
    expect(page).to have_content "Question successfully deleted"
  end

  context 'after a question has been created' do
    before(:each){ @question = create :question, event: event }

    it "the question show page has a link back to its event" do
      visit question_path(@question)
      expect(page).to have_selector(:link_or_button, "Back to #{event.title}")
    end

    it "event show page has a button to 'Publish' the question" do
      visit event_path(event)
      expect(page).to have_selector(:link_or_button, 'Publish')
    end

    it "user can publish the question" do
      expect_any_instance_of(Pusher::Client).to receive(:trigger)
      visit event_path(event)
      click_on 'Publish'
      expect(current_path).to eq  question_path(@question)
      expect(page).to have_content 'Question has been pushed to the audience'
    end

    it "alerts user to issue publishing question" do
      expect_any_instance_of(Pusher::Client).to receive(:trigger).and_raise("ERROR")
      visit event_path(event)
      click_on 'Publish'
      expect(current_path).to eq  event_path(event)
      expect(page).to have_content 'Error: Question could not be published'
    end

    context "when a question's choices do not have any votes" do
      before :each do
        @choice1 = create :choice, question: @question
        @choice2 = create :choice, question: @question
      end

      it "'Clear Votes' link is not displayed on the question show page" do
        visit question_path @question
        expect(page).not_to have_content "Clear Votes"
      end
    end

    context "when a question's choices has some votes" do
      before :each do
        @choice1 = create :choice, question: @question
        @choice2 = create :choice, question: @question
        @choice1.votes.create
        2.times{ @choice2.votes.create }
      end

      it '(with a page refresh) votes are shown on the question show page' do
        visit question_path @question
        expect(page).to have_content "#{@choice1.content}"
        expect(page).to have_content "#{@choice2.content}"
        expect(page).to have_content "Votes: #{@choice1.votes.count}"
        expect(page).to have_content "Votes: #{@choice2.votes.count}"
      end

      it "a question's votes can be cleared with the press of a button on its show page" do
        visit question_path @question
        click_on "Clear Votes"
        expect(page).not_to have_content "Votes: 1"
        expect(page).to have_content "Votes successfully cleared"
      end
    end

  end
end
