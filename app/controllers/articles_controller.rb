class ArticlesController < ApplicationController

  before_filter :authorize, except: [:show_all]

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to controller: 'sessions', action: 'new' , notice: "Please log in"
    end
  end

  def index           
      @articles = Article.where(:user_id => session[:user_id])
  end

  def show
      @article = Article.find(params[:id])
  end

  def show_all
      @articles = Article.all
  end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
    @article.user_id = session[:user_id]
    
      if @article.save
    		redirect_to article_path(@article)
  		else
    		render 'new'
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
    		render 'edit'
  		end
	end

	def destroy
  		@article = Article.find(params[:id])
  		@article.destroy
 
  		redirect_to articles_path
	end

private
  	def article_params
    	params.require(:article).permit(:title, :text)
  	end

end
