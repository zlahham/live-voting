require 'rails_helper'

RSpec.describe EventsController do
  describe '#parse_event_id' do
    it 'redirects to correct voting page when given an id' do
      event = create :event, user: create(:user)
      event.update_attributes(code: ("ABCD" + "#{event.id}"))
      get(:parse_event_id, {'controller' => 'events', 'action' => 'parse_event_id', 'unparsed_event_id' => event.code})
      expect(response).to redirect_to vote_event_path(event.id)
    end

    it "doesn't redirect to a voting page when given an incorrect id" do
      event = create :event, user: create(:user)
      event.update_attributes(code: ("ABCD" + "#{event.id}"))
      get(:parse_event_id, {'controller' => 'events', 'action' => 'parse_event_id', 'unparsed_event_id' => ("1234" + "#{event.id}")})
      expect(response).to redirect_to events_path
    end

    it 'redirects to correct voting page when given a lowercase id' do
      event = create :event, user: create(:user)
      event.update_attributes(code: ("ABCD" + "#{event.id}"))
      get(:parse_event_id, {'controller' => 'events', 'action' => 'parse_event_id', 'unparsed_event_id' => "abcd" + "#{event.id}"})
      expect(response).to redirect_to vote_event_path(event.id)
    end
  end
end
