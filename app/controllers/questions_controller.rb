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
    p "PARAMS FROM PUBLISH_QUESTION: "
    p params
    build_json(params["question"], params["id"])
    redirect_to event_path
    flash[:notice] = "Question has been pushed to the audience"
  end

  def build_json(question_id, event_id)
    event = Event.find(event_id)
    p "EVENT IN BUILD_JSON METHOD: "
    p event.inspect

    question = Question.find(question_id)
    p "QUESTION IN BUILD_JSON METHOD: "
    p question.inspect
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end