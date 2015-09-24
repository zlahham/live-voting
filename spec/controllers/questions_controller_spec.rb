require 'rails_helper'

RSpec.describe QuestionsController do
  include Capybara::DSL

  describe '#publish_question' do
    it 'calls push_json_to_pusher method' do
      user = create :user
      event = create :event, user: user
      question = create :question, event: event

      expect_any_instance_of(Pusher::Client).to receive :trigger

      get(:publish_question, {"question" => question.id, "controller"=>"questions", "action"=>"publish_question", "id"=>event.id})
    end
  end

  describe '#build_json' do
    it 'returns an acceptable json object for pusher' do
      user =      create(:user)
      event =     user.events.create(title: 'test')
      question =  event.questions.create(content: 'test question')
      choice =    question.choices.create(content: 'test choice')
      choice2 =   question.choices.create(content: 'best choice')
      
      sign_in_as(user)

      p = QuestionsController.new

      expect(JSON.parse(p.build_json event, question)).to eq( {"event"=>{"id"=>event.id, "title"=>"test"}, "question"=>{"id"=>question.id, "content"=>"test question"}, "choices"=>[{"content"=>"test choice", "id"=>choice.id}, {"content"=>"best choice", "id"=>choice2.id}]} )
    end
  end

  private

  def sign_in_as(user)
    visit root_path
    click_link 'Sign in'
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log in'
  end
end