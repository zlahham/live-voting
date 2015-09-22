require 'rails_helper'

RSpec.describe Event, type: :model do

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to belong_to :user }

  describe 'create event' do

    let(:user) { create(:user) }

    it 'can be created' do
      expect{ Event.create(title: 'test', user: user) }.to change{ Event.count }.by(1)
    end
  end
end
