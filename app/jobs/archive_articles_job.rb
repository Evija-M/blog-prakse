# frozen_string_literal: true

class ArchiveArticlesJob < ApplicationJob
  @queue = :archive_articles

  def perform
    articles = Article.non_archived.older_than_week
    articles.each do |article|
      article.update(status: 'archived')
    end
  end
end
