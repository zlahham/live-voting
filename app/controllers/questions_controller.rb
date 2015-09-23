class QuestionsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @question = Question.new
  end

  def create
    @event = Event.find(params[:event_id])
    @question = @event.questions.new(question_params)

    if @question.save
      flash[:notice] = "Question successfully created"
      redirect_to event_path(@event)
    else
      render 'questions/new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end