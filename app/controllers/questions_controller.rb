class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ] # deviseのヘルパー。ログイン必須(index,show以外)
  before_action :set_question, only: [ :show, :edit, :update, :destroy ]

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).includes(:user, :spot, :category).order(created_at: :desc).page(params[:page]) # Kaminari の page メソッドを追加
  end

  def show
    @answer = Answer.new # 新規回答フォーム用
    @answers = @question.answers.includes(:user) # N+1問題を避ける
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: "質問を投稿しました。"
    else
      render :new
    end
  end

  def edit
    # 投稿者本人だけが編集できるようにする
    if @question.user != current_user
        redirect_to @question, alert: "権限がありません"
    end
  end

  def update
      if @question.user == current_user
        if @question.update(question_params)
          redirect_to @question, notice: "質問を更新しました。"
        else
          render :edit
        end
      else
          redirect_to @question, alert: "権限がありません"
      end
  end

  def destroy
    if @question.user == current_user
        @question.destroy
        redirect_to questions_path, notice: "質問を削除しました。"
    else
       redirect_to @question, alert: "権限がありません"
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
        params.require(:question).permit(:title, :body, :spot_name, :category_id)
  end
end
