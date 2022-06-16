# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = policy_scope(Article)
  end

  def show
    @article = Article.with_deleted.find(params[:id])
    authorize @article
  end

  def new
    @article = Article.new
    authorize @article
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
    @article = Article.with_deleted.find(params[:id])
    authorize @article, :edit?
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
    @article = Article.with_deleted.find(params[:id])
    if authorize @article, :destroy?
      @article.destroy
      redirect_to root_path, status: :see_other
    else
      redirect_to root_path
    end
  end

  def showarchived
    @articles = Article.where(status: 'archived')
  end

  def show_user_articles
    authorize current_user, :show_user_articles?, policy_class: ArticlePolicy
    @articles = current_user.articles
  end

  def show_user_deleted_articles
    authorize current_user, :show_user_articles?, policy_class: ArticlePolicy
    @deleted_articles = current_user.articles.only_deleted
  end

  def restore_article
    @article = Article.only_deleted.find(params[:article_id])
    authorize @article, :restore?
    @article.recover(recursive: true)
    redirect_to @article
  end

  def export
    @articles = policy_scope(Article)
    respond_to do |format|
      format.xlsx
    end
    render xlsx: 'export_articles', disposition: :inline
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status, :user_id)
  end
end
