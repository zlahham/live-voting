class ChoicesController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @choice = Choice.new
  end

  def create
    @question = Question.find(params[:question_id])
    @choice = @question.choices.new(choices_params)
      
    if @choice.save
      redirect_to question_path(@question)
      flash[:notice] = "Choice successfully created"
    else
      render 'choices/new'
    end
  end

  def destroy
    choice = Choice.find(params[:id]).destroy
    redirect_to question_path(choice.question)
    flash[:notice] = "Choice successfully deleted"
  end

  private

  def choices_params
    params.require(:choice).permit(:content)
  end
end