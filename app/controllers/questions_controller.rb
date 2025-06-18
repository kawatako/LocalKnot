class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_question, only: [ :show, :edit, :update, :destroy, :choose_best_answer, :remove_best_answer ]

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).includes(:user, :spot, :category)

    case params[:sort]
    when "answers_count"
      # 回答数順 (回答数が多い順)
      @questions = @questions.left_joins(:answers)
                             .group("questions.id")
                             .select("questions.*, COUNT(answers.id) AS answers_count")
                             .order("answers_count DESC")
    when "updated_at"
        # 更新日順
        @questions = @questions.order(updated_at: :desc)
    else
      # デフォルト: 新着順
      @questions = @questions.order(created_at: :desc)
    end
    if params[:resolved] == "true"
      @questions = @questions.where(resolved: true)
    elsif params[:resolved] == "false"
      @questions = @questions.where(resolved: false)
    end
    @questions = @questions.page(params[:page])
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
      flash.now[:alert] = "質問の投稿に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if @question.user != current_user
        redirect_to @question, alert: "権限がありません"
    end
    @question.spot_name = @question.spot.name if @question.spot.present?
  end

  def update
      if @question.user == current_user
        if @question.update(question_params)
          redirect_to @question, notice: "質問を更新しました。"
        else
          flash.now[:alert] = "質問の更新に失敗しました。"
          render :edit, status: :unprocessable_entity
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

  def choose_best_answer
    @answer = @question.answers.find(params[:answer_id])
    if @question.user == current_user
      @question.update(best_answer: @answer)
      redirect_to @question, notice: "ベストアンサーを選択しました。"
    else
      redirect_to @question, alert: "権限がありません"
    end
  end

  def remove_best_answer
    if @question.user == current_user
      @question.update(best_answer: nil)
      redirect_to @question, notice: "ベストアンサーを解除しました。"
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
