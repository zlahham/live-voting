require 'rails_helper'

RSpec.describe Voter, type: :model do

  it { is_expected.to have_many :votes }
  it { is_expected.to belong_to :event }


end
