require 'rails_helper'

RSpec.describe BuildJSON do
  let(:user)      { create :user }
  let(:event)     { create :event, user: user }
  let(:question)  { create :question, event: event }
  let(:choice)    { create :choice, question: question }
  let(:choice2)   { create :choice, question: question, content: "No" }

  describe '#build_json' do
    it 'returns an acceptable json object for pusher' do
      question.update_attributes(choices: [choice, choice2])
      expect(JSON.parse(BuildJSON.call(event, question))).to eq( {"event"=>{"id"=>event.id,
              "title"=>event.title,
              "code"=>"ABCD1",
              "description"=>"The first event of hopefully many, in which we show off our technology"},
              "question"=>{"id"=>question.id,
              "content"=>question.content,
              "question_number"=>1},
              "choices"=>[{"content"=>choice.content, "id"=>choice.id}, {"content"=>choice2.content, "id"=>choice2.id}]} )
    end
  end
end
