require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user){ create :user }


  it { is_expected.to belong_to :event }
  it { is_expected.to have_many :choices }
  
  it { is_expected.to validate_presence_of :event }
  it { is_expected.to validate_presence_of :content }

  it 'is destroyed when parent event is destroyed' do
    event =     create :event, user: user
    question =  create :question, event: event

    expect{ event.destroy }.to change{ Question.count }.by -1
    expect( event.questions.include? question ).to eq false
  end
end