class QuestionsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
    @event = Event.find(params[:event_id])
    @question = @event.questions.new(question_params)

    if @question.save
      flash[:notice] = "Question successfully created"
      redirect_to question_path(@question.id)
    else
      render 'questions/new'
    end
  end

  def publish_question
    event =     Event.find(params["id"])
    question =  Question.find(params["question"])

    json_object = build_json(event, question)

    push_json_to_pusher(json_object)

    redirect_to event_path
    flash[:notice] = "Question has been pushed to the audience"
  end

  def build_json(event, question)
    choices = {}
    p question.choices.inspect
    question.choices.each do |choice|
      p "CHOICE = "
      p choice
      choices.store(choice.id, choice.content)
    end

    json_object = {event_title: event.title, question: question, choices: choices}.to_json
    # p json_object
  end

  def push_json_to_pusher(json_object)

  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end