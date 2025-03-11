class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Blog.ransack(params[:q])
    @blogs = @q.result(distinct: true).includes(:user, :category, :spot).order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @blog = Blog.new
    @images = current_user.images
  end

  def edit
    @images = current_user.images
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.', status: :see_other
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    # strong parameters
    params.require(:blog).permit(:title, :content, :thumbnail_image_id, :user_id, :category_id, :spot_name, :status)
  end
  # 追加: ログインユーザーとブログの投稿者が一致するか確認
  def correct_user
    @blog = current_user.blogs.find_by(id: params[:id])
    redirect_to root_url, alert: "権限がありません" if @blog.nil?
  end

end