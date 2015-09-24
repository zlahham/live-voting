require 'rails_helper'

RSpec.describe QuestionsController do
  let(:user)      { create :user }
  let(:event)     { create :event, user: user }
  let(:question)  { create :question, event: event }
  let(:choice)    { create :choice, question: question }
  let(:choice2)   { create :choice, question: question, content: "No" }

  describe '#publish_question' do
    it 'calls push_json_to_pusher method' do
      expect_any_instance_of(Pusher::Client).to receive :trigger
      get(:publish_question, {"question" => question.id, "controller"=>"questions", "action"=>"publish_question", "id"=>event.id})
    end

    it 'sends correct event_id to #push_json_to_pusher' do
      expect_any_instance_of(Pusher::Client).to receive(:trigger).with(anything, ("event_" + "#{event.id}"), anything)
      get(:publish_question, {"question" => question.id, "controller"=>"questions", "action"=>"publish_question", "id"=>event.id})
    end
  end

  describe '#build_json' do
    it 'returns an acceptable json object for pusher' do
      question.update_attributes(choices: [choice, choice2])
      expect(JSON.parse(subject.build_json event, question)).to eq( {"event"=>{"id"=>event.id, "title"=>event.title}, "question"=>{"id"=>question.id, "content"=>question.content}, "choices"=>[{"content"=>choice.content, "id"=>choice.id}, {"content"=>choice2.content, "id"=>choice2.id}]} )
    end
  end
end