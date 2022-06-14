# frozen_string_literal: true

require 'rails_helper'

describe 'Article' do
  context 'validations' do
    let!(:article) { create :article }

    it 'title must be persisted ' do
      article.title = nil
      expect(article).to_not be_valid
      expect(article.errors[:title].count).to eq(1)
    end

    it 'body length cannot be less than 5' do
      article.body = '1234'
      expect(article).to_not be_valid
      expect(article.errors[:body].count).to eq(1)
    end

    it 'body length must be at least 5' do
      article.body = '12345'
      expect(article).to be_valid
    end
  end
end
