require 'rails_helper'

feature 'Home page' do
  let(:user){ create :user }

  context 'when signed out' do
    it "You see marketing spiel, and not your events" do
      visit root_path
      expect(page).to have_content "We have great live polling tools"
      expect(page).not_to have_content "Event 1"
    end
  end

  context 'when you sign in' do
    before(:each){ sign_in_as user }

    context "and you don't have any events" do
      it "You see a notification encouraging you to create an event" do
        visit events_path
        expect(page).to have_content "You don't have any events yet - why not add one below?"
        expect(page).not_to have_content "We have great live polling tools"
      end
    end

    context 'you have one or more events', js: true do
      it "You see your events, and not marketing spiel" do
        event = create :event, user: user
        visit events_path
        expect(page).to have_content "#{event.title}"
        expect(page).not_to have_content "We have great live polling tools"
      end

      it 'the no events notice is not displayed' do
        event = create :event, user: user
        visit events_path
        expect(page).not_to have_content "You don't have any events yet - why not add one below?"
      end
    end
  end
end