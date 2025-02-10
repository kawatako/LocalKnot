# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[edit update] # 追加
  before_action :ensure_correct_user, only: %i[edit update]

  def show
    @profile = current_user.profile || current_user.build_profile
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile # 追加
    @profile = current_user.profile || current_user.build_profile
  end

  # 自分以外のユーザーの編集・更新を禁止
  def ensure_correct_user
    redirect_to root_path, alert: "権限がありません" unless current_user == @profile.user
  end

  def profile_params
    params.require(:profile).permit(:user_name, :introduction, :avatar, :avatar_cache, :birthdate, :gender, :website)
  end
end
