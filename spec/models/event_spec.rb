require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'can be created' do
    expect{Event.create}.to change{Event.count}.by(1)
  end
end
