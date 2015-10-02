class ChoicesController < ApplicationController
  before_action :check_if_choice_owner, only: [:new, :create]

  def new
    @question = find_question
    @choice = Choice.new
  end

  def create
    @question = find_question
    @choice = @question.choices.new(choices_params)

    if @choice.save
      redirect_to question_path(@question)
      flash[:notice] = "Choice successfully created"
    else
      render 'choices/new'
    end
  end

  def destroy
    choice = find_choice
    choice.destroy
    redirect_to question_path(choice.question)
    flash[:notice] = "Choice successfully deleted"
  end


  private

  def find_question
    Question.find(params[:question_id])
  end

  def find_choice
    Choice.find(params[:id])
  end

  def check_if_choice_owner
    question = find_question
    if current_user != question.event.user
      redirect_to root_path, notice: "Sorry, but we were unable to serve your request."
    end
  end

  def choices_params
    params.require(:choice).permit(:content)
  end
end