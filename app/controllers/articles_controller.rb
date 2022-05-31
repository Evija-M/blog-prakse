# frozen_string_literal: true

class ArticlesController < ApplicationController
  # around_action :change_lang
  def index
    @articles = Article.all
  end

  def show
    @article  = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      UserMailer.new_article_email(current_user, @article).deliver
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    redirect_to @article if current_user.id != @article.user_id
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.user_id == current_user.id
      @article.destroy
      redirect_to root_path, status: :see_other
    else
      redirect_to root_path
    end
  end

  def showarchived
    @articles = Article.where(status: 'archived')
  end

  def show_user_rticles
    @articles = Article.where(user_id: current_user.id)
  end

  def export
    @articles = Article.all
    respond_to do |format|
      format.xlsx
    end
    render xlsx: 'export_articles', disposition: inline
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status, :user_id)
  end
end
