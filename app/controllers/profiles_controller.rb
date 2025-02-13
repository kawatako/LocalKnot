# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_profile, only: %i[show edit update]
  before_action :ensure_correct_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @profile = @user.profile || Profile.new
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました" # 正しい: 自分のプロフィールにリダイレクト
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    if params[:id]
      @profile = Profile.find_by(user_id: params[:id]) # 他のユーザーのプロフィール
    else
      @profile = current_user.profile || current_user.build_profile # 自分のプロフィール
    end
  end

    def ensure_correct_user
     redirect_to root_path, alert: "権限がありません" unless current_user == @profile.user
    end

  def profile_params
    params.require(:profile).permit(:user_name, :introduction, :avatar, :avatar_cache, :birthdate, :gender, :website)
  end
end
