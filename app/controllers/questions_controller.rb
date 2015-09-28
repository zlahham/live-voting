class QuestionsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    choices = []
    @labelscommas = ""
    @question.choices.each do |choice|
      choices << choice.content
    end
    choices.each do |content|
      @labelscommas += content + ","
    end
    vote_numbers = []
    @datacommas = ""
    @question.choices.each do |choice|
      vote_numbers << choice.votes.count.to_s
    end
    vote_numbers.each do |content|
      @datacommas += content + ","
    end
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
    questions_array = event.questions
    event = event.attributes.reject!{|key,value| %w"updated_at created_at user_id".include? key}
    question = question.attributes.reject!{|key,value| %w"updated_at created_at event_id".include? key}
    question_number = questions_array.index(question).to_i + 1
    question.merge!(question_number: question_number)
    json_object = { event: event, question: question, choices: choices_array }.to_json
  end

  def push_json_to_pusher(json_object, event_id)
    pusher = Pusher::Client.new app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret
    pusher.trigger('test_channel', 'event_' + event_id.to_s, json_object)
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
