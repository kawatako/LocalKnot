class ImagesController < ApplicationController
  before_action :authenticate_user! # ログイン必須にする

  def new
    @image = Image.new
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @image = current_user.images.new(image_params)
    if @image.save
      respond_to do |format|
        format.html { redirect_to images_path, notice: "Image was successfully uploaded." }
        format.turbo_stream { render turbo_stream: turbo_stream.append("image-list", partial: "images/image", locals: { image: @image }) }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@image, partial: "images/form", locals: { image: @image }) }
      end
    end
end

  def index
    @images = current_user.images.all # 変更: 現在のユーザーの画像のみ取得
  end

  def destroy
    @image = current_user.images.find(params[:id])
      @image.destroy
      respond_to do |format|
        format.html { redirect_to images_path, notice: '画像を削除しました' }
        format.turbo_stream # destroy.turbo_stream.erb をレンダリング
      end
  end

  private

  def image_params
    params.require(:image).permit(:title, :file)
  end
end