class AnswersController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = @user.question.answers.new
  end
  def create
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = @user.question.answers.new(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end
  def edit
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    render :edit
  end
  def update
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end
  def destroy
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end
  private
  def answer_params
    params.require(:answer).permit(:description, :title, :user)
  end
end
