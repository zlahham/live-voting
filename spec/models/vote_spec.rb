require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { is_expected.to belong_to :choice }
  it { is_expected.to belong_to :voter }
  it { is_expected.to validate_presence_of :choice }

  it "can be created on a choice" do
  	choice = create(:choice)
  	expect{choice.votes.create}.to change{choice.votes.count}.by 1
  end

end
