require 'rails_helper'

RSpec.describe Choice, type: :model do
  let(:event){ create :event, user: (create :user) }

  it { is_expected.to belong_to :question }
  it { is_expected.to have_many :votes }

  it 'is destroyed when its parent question is destroyed' do
    question = create :question, event: event
    choice = create :choice, question: question
    expect{ question.destroy }.to change{Choice.count}.by -1
    expect(question.choices.include? choice).to eq false
  end
end