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
    redirect_to event_path
    flash[:notice] = "Question has been pushed to the audience"
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end