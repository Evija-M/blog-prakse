# frozen_string_literal: true

require 'rails_helper'

describe 'Comment' do
  context 'validations' do
    let!(:comment) { create :comment }
    it 'length should be [2;10]' do
      expect(comment).to be_valid
      expect(comment.errors[:commenter].count).to eq(0)
    end
    it 'commenter must be persisted' do
      comment.commenter = nil
      expect(comment).not_to be_valid
      expect(comment.errors[:commenter].count).not_to eq(0)
    end
    it 'lenght should be [2;10]' do
      comment.commenter = '1234567890'
      expect(comment).to be_valid
      expect(comment.errors[:commenter].count).to eq(0)
    end
  end
end
