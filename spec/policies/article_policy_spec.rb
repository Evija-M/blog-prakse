# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePolicy, type: :policy do
  subject { described_class }
  let!(:user) { create :user }
  let!(:article) { create :article }
  let!(:article_deleted) { create :article }

  permissions :destroy?, :restore? do
    it 'denies access to delete/restore post if it belongs to other user' do
      expect(subject).not_to permit(user, article)
    end
    it "allows to delete/restore user's own posts" do
      expect(subject).to permit(article.user, article)
    end
  end

  permissions :edit? do
    it 'doesnt allow to edit deleted post' do
      article_deleted.delete
      expect(subject).not_to permit(article_deleted.user, article_deleted)
    end

    it "allows to edit only user's own posts" do
      expect(subject).to permit(article.user, article)
    end
  end
end
