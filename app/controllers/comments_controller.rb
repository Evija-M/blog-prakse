# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    authorize current_user, :signed_in?
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
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

  def restore_comment
    @comment = Comment.only_deleted.find(params[:comment_id])
    authorize @comment, :destroy?
    @article = Article.with_deleted.find(@comment.article_id)
    if @article.deleted_at.nil?
      @comment.recover
      redirect_to @article
    else
      flash[:error] = 'You cant restore this comment because article is still deleted'
      redirect_to deleted_articles_users_path
    end
  end

  def delete_comment
    @comment = Comment.only_deleted.find(params[:comment_id])
    authorize @comment, :destroy?
    @comment.destroy_fully!
    redirect_to deleted_comments_users_path
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :user_id)
  end
end
