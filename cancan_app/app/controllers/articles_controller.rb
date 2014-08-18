class ArticlesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @articles = Article.find(:all)
  end
  
  def show
    @comment = Comment.new(:article => @article)
  end
  
  def new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Successfully created article."
      redirect_to @article
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @article.update_attributes(params[:article])
      flash[:notice] = "Successfully updated article."
      redirect_to @article
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @article.destroy
    flash[:notice] = "Successfully destroyed article."
    redirect_to articles_url
  end

  private

  def article_params
    params.require(:article).permit(:name, :content, :author_name)
  end
end
