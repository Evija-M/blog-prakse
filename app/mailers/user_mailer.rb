# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'example@example.com'
  def new_article_email(user, article)
    @user = user
    @article = article
    mail(to: @user.email, subject: 'New article is made')
  end
end
