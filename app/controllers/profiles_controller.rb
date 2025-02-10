# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[edit update]

  def show
    @profile = current_user.profile || current_user.build_profile
  end

  def edit
    @profile = current_user.profile || current_user.build_profile
  end

  def update
    @profile = current_user.profile || current_user.build_profile
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました" # リダイレクト先を修正
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # 自分以外のユーザーの編集・更新を禁止
    def ensure_correct_user
      # @user ではなく @profile.user を使うように修正
      redirect_to root_path, alert: "権限がありません" unless current_user == @profile.user
    end

  def profile_params
    params.require(:profile).permit(:user_name, :introduction, :avatar, :avatar_cache, :birthdate, :gender, :website)
  end
end