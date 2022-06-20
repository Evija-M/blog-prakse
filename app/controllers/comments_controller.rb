# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    authorize @comment
    respond_to do |format|
      format.html { redirect_to article_path(@article) }
    end
  end

  def destroy
    @article = Article.with_deleted.find(params[:article_id])
    @comment = @article.comments.with_deleted.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to deleted_comments_users_path(current_user.id)
  end

  def show_user_deleted_comments
    authorize current_user, :show?, policy_class: CommentPolicy
    @deleted_comments = current_user.comments.only_deleted
  end

  def restore
    @comment = Comment.only_deleted.find(params[:comment_id])
    authorize @comment, :restore?
    @comment.recover
    @article = Article.where(id: @comment.article_id).first
    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :user_id)
  end
end
