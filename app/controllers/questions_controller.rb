class QuestionsController <ApplicationController
  def index
    # binding.pry

    # if (params[:sort_order])
    #   @sort_order = (params[:sort_order])
    # else
    #   @sort_order = "name"
    # end
    @users = User.all

    @user = User.find(params[:user_id])
    # @questions = Question.all.sort_by {|question| question.public_send(@sort_order) }
    @questions = Question.all
    @random_question = Question.order("RANDOM()").first

  end

  def search
    # @results = Wine.basic_search(params)
    binding.pry
  end

  def new
    @user = User.find(params[:user_id])
    # @question = Question.new
    @question = @user.questions.new
  end

  def create
    @user = User.find(params[:user_id])
    # @question = Question.new(question_params)
    @question = @user.question.new(question_params)
    if @question.save
      redirect_to user_questions_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @question = Question.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @question = Question.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :description, :user)
  end
end
