# frozen_string_literal: true

require 'rails_helper'
Devise::Mailer.perform_deliveries = false

RSpec.describe 'New article', type: :request do
  context 'GET /new_article' do
    let!(:user) { create :user }
    it 'returns successful redirect' do
      visit user_session_path
      fill_in 'E-mail', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      visit new_article_path
      expect(page).to have_http_status(200)
    end
  end
end

RSpec.describe 'Creating new article' do
  context 'GET /new_article' do
    let!(:article) { create :article }
    it 'returns new article page after submitting it' do
      visit user_session_path
      fill_in 'E-mail', with: article.user.email
      fill_in 'Password', with: article.user.password
      click_button 'Log in'
      visit new_article_path
      fill_in 'Title', with: article.title
      fill_in 'Text', with: article.body
      page.select 'public', from: 'Status'
      click_on 'Submit'
      expect(page).to have_content(article.title)
      expect(page).to have_content(article.body)
    end
  end
end
