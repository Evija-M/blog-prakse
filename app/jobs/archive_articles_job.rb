# frozen_string_literal: true

class ArchiveArticlesJob < ApplicationJob
  @queue = :archive_articles

  def perform(articles)
    non_archived_articles = articles.where.not(status: 'archived')
    non_archived_articles.each do |article|
      date_now = Time.now
      Article.update(status: 'archived') unless article.updated_at.between?(date_now - 1.week, date_now)
    end
  end
end
