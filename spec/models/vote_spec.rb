require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:event){ create :event, user: (create :user) }


  it { is_expected.to belong_to :choice }
  it { is_expected.to belong_to :voter }
  it { is_expected.to validate_presence_of :choice }

  before :each do
    question = create :question, event: event
    @choice = create :choice, question: question
  end

  it "can be created on a choice" do
    expect{@choice.votes.create}.to change{@choice.votes.count}.by 1
  end

  it 'is destroyed when parent choice is destroyed' do
    vote = create :vote, choice: @choice
    expect{ @choice.destroy }.to change{ Vote.count }.by -1
    expect( @choice.votes.include? vote ).to eq false
  end
end
