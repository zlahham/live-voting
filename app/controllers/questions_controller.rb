class QuestionsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @question = Question.new
    2.times { @question.choices.build }
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

  def destroy
    question = Question.find(params[:id]).destroy
    redirect_to event_path(question.event)
    flash[:notice] = "Question successfully deleted"
  end

  def clear_votes
    question = Question.find(params[:id])
    question.choices.map{ |choice| choice.votes.destroy_all }
    redirect_to question_path(question)
    flash[:notice] = "Votes successfully cleared"
  end

  def publish_question
    question = Question.find(params["question"])
    event = question.event
    json_object = BuildJSON.call(event, question)
    begin
      push_json_to_pusher(json_object, event.id)
      redirect_to question_path(question)
      flash[:notice] = "Question has been pushed to the audience"
    rescue
      redirect_to event_path(event)
      flash[:notice] = "Error: Question could not be published"
    end
  end

  def push_json_to_pusher(json_object, event_id)
    pusher = Pusher::Client.new app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret
    pusher.trigger('test_channel', 'event_' + event_id.to_s, json_object)
  end

  def add_choice
  @question = Question.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, choices_attributes:[:content])
  end
end