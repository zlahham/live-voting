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

  def edit
    @question = Question.find(params[:id])

  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:notice] = "Question successfully updated"
      render 'show'
    else
      render 'edit'
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
    event =       Event.find(params["id"])
    question =    Question.find(params["question"])
    json_object = build_json(event, question)
    begin
      push_json_to_pusher(json_object, event.id)
      redirect_to question_path(question)
      flash[:notice] = "Question has been pushed to the audience"
    rescue
      redirect_to event_path(event)
      flash[:notice] = "Error: Question could not be published"
    end
  end

  def build_json(event, question)
    choices_array = []
    question.choices.each do |choice|
      choice_hash = { content: choice.content, id: choice.id }
      choices_array << choice_hash
    end
    event_object = event.attributes.reject!{|key,value| %w"updated_at created_at user_id".include? key}
    question_object = question.attributes.reject!{|key,value| %w"updated_at created_at event_id".include? key}
    question_object.merge!(question_number: question_number(event, question))
    json_object = { event: event_object, question: question_object, choices: choices_array }.to_json
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

  def question_number(event, question)
    questions_array = event.questions.all.order(:id)
    question_number = questions_array.index(question).to_i + 1
  end

  def question_params
    params.require(:question).permit(:content, choices_attributes:[:id, :content])
  end
end
