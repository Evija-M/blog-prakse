# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  context 'send an email about new article' do
    let(:article) { create :article, :other }
    let(:mail) { UserMailer.new_article_email(article.user, article) }
    it 'returns attributes' do
      expect(mail.subject).to eq('New article is made')
      expect(mail.from).to eql(['example@example.com'])
      expect(mail.to.join).to eq(article.user.email)
      expect(mail.body).to have_content(article.title)
    end
  end
end
