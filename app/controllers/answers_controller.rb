class AnswersController < ApplicationController
  before_action :authenticate_user! # deviseのヘルパー。ログイン必須
    before_action :set_question, only: [ :create, :edit, :update ]
  before_action :set_answer, only: [ :edit, :update, :destroy ]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: "回答を投稿しました。"
    else
      @answers = @question.answers.includes(:user) # 追加: エラー時に既存の回答を再取得
      render "questions/show"
    end
  end

    def edit
      if @answer.user != current_user
        redirect_to @answer.question, alert: "権限がありません"
      end
    end

    def update
      if @answer.user == current_user
        if @answer.update(answer_params)
          redirect_to @answer.question, notice: "回答を更新しました。"
        else
          render :edit
        end
      else
        redirect_to @answer.question, alert: "権限がありません"
      end
    end

  def destroy
     if @answer.user == current_user
        @answer.destroy
        redirect_to @answer.question, notice: "回答を削除しました。"
     else
       redirect_to @question, alert: "権限がありません"
     end
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:body)
    end
end
