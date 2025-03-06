class ImagesController < ApplicationController
  before_action :authenticate_user! # ログイン必須にする

  def new
    @image = Image.new
  end

  def create
    @image = current_user.images.new(image_params) # 変更: current_user の images として作成
    if @image.save
      respond_to do |format|
        format.html { redirect_to images_path, notice: "Image was successfully uploaded." }
        format.json { render json: { id: @image.id, url: url_for(@image.file) }, status: :created }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @images = current_user.images.all # 変更: 現在のユーザーの画像のみ取得
  end

  def destroy
    @image = current_user.images.find(params[:id]) # 変更: 現在のユーザーの画像から検索
    @image.destroy
    redirect_to images_path, notice: "Image was successfully deleted.", status: :see_other
  end

  private

  def image_params
    params.require(:image).permit(:title, :file)
  end
end