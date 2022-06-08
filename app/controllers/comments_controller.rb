# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    authorize @article
    @comment = @article.comments.create(comment_params)
    authorize @comment
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to article_path(@article), status: 303
  end

  def show_user_deleted_comments
    authorize current_user, :show?
    @deleted_comments = Comment.only_deleted.where('user_id = ?', current_user.id)
  end

  def restore
    @comment = Comment.only_deleted.find(params[:comment_id])
    authorize @comment, :restore?
    @article = Article.with_deleted.find(@comment.article_id)
    if @article.deleted_at.nil?
      @comment.recover
      redirect_to @article
    else
      flash[:error] = t('errors.unable_to_restore')
      redirect_to deleted_articles_users_path
    end
  end

  def delete
    @comment = Comment.only_deleted.find(params[:comment_id])
    authorize @comment, :destroy?
    @comment.destroy_fully!
    redirect_to deleted_comments_users_path(current_user.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :user_id)
  end
end
