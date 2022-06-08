# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
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
    @article = Article.find(params[:id])
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
    @article = Article.find(params[:id])
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
    authorize current_user, :show?
    @articles = policy_scope(Article)
  end

  def show_user_deleted_articles
    authorize current_user, :show?
    @deleted_articles = Article.only_deleted.where('user_id = ?', current_user.id)
  end

  def restore_article
    @article = Article.only_deleted.find(params[:article_id])
    authorize @article, :edit?
    @article.recover(recursive: true)
    redirect_to @article
  end

  def delete
    @article = Article.only_deleted.find(params[:article_id])
    authorize @article, :delete?
    @article.destroy_fully!
    redirect_to deleted_articles_users_path
  end

  def export
    @articles = Article.all
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
