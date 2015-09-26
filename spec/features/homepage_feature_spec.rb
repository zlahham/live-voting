require 'rails_helper'

feature 'Home page' do
  let(:user){ create :user }
  let(:event){ create :event, user: create(:user) }

  context 'when signed out' do
    it "You see marketing spiel, and not your events" do
      visit root_path
      expect(page).to have_content "We have great live polling tools"
      expect(page).not_to have_content "Event 1"
    end
  end

  context 'when signed in' do

    context "you haven't made an event" do
      it "You see a link to get started, and not marketing spiel" do
        visit root_path
        sign_in_as user
        expect(page).to have_content "Click here to create your first event"
        expect(page).not_to have_content "We have great live polling tools"
      end
    end

    context 'you have made an event' do
      it "You see your events, and not marketing spiel" do
        visit root_path
        sign_in_as user
        click_on 'Create Event'
        fill_in 'event_title', with: 'Event 1'
        click_on 'Add Event'
        visit root_path
        expect(page).to have_content "Event 1"
        expect(page).not_to have_content "We have great live polling tools"
      end
    end
  end
end
