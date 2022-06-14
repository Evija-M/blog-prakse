# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }
  let(:comment) { create :comment }

  permissions :restore? do
    it 'allows to restore comment only if article is not deleted' do
      comment.article.delete
      comment.delete
      expect(subject).not_to permit(comment.user, comment)
    end
  end
end
