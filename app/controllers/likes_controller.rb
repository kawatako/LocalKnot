class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.find(params[:answer_id])
    current_user.likes.create!(answer: @answer)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @answer.question }
    end
  end

  def destroy
    @answer = Answer.find(params[:answer_id])
    like = current_user.likes.find_by!(answer: @answer)
    like.destroy!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @answer.question }
    end
  end
end
