class ArticlesController < ApplicationController
  #around_action :change_lang
  #http_basic_authenticate_with name: "evija", password: "12345", except: :index
  def index
    @articles = Article.all
  end

  def show
    @article  = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
      @article = Article.find(params[:id])
  end
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to root_path, status: :see_other
  end

  def showarchived
    @article = Article.find_by(status: 'archived')
  end

  #def change_lang
  #  locale = params[:locale] || I18n.default_locale
  #  I18n.locale = locale
  #  redirect_to root_path
  #end
  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
