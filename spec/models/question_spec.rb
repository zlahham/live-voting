require 'rails_helper'

RSpec.describe Question, type: :model do
  it{ is_expected.to belong_to :event }
  it{ is_expected.to validate_presence_of :event }
end
