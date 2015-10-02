require 'rails_helper'

describe ClearVotes do
  let(:user)      { create :user }
  let(:event)     { create :event, user: user }
  let(:question)  { create :question, event: event }
  let(:choice)    { create :choice, question: question }
  let(:choice2)   { create :choice, question: question, content: "No" }

  it "destroys a question's votes" do
    choice.votes.create
    2.times{choice2.votes.create}
    ClearVotes.call(question)
    question.choices.map{ |choice| expect(choice.votes.count).to eq 0 }
  end
end