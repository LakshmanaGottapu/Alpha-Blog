class ArticlesController < ApplicationController
    before_action :require_user, except: [:index, :show]
    before_action :set_article, only: [:show, :update, :edit, :destroy]
    before_action :require_same_user, only: [:edit, :update,:destroy]
    def index
        # @articles = Article.all
        @articles = Article.paginate(page: params[:page], per_page: 5) 
    end
    def new
        @article = Article.new()
    end
    def create 
        @article = Article.new(article_params)
        @article.user = @_current_user
        if @article.save
            flash[:notice] = "Article was created Successfully"
            redirect_to @article
        else 
            render 'new'
        end
    end
    def show
        @article = Article.find(params[:id])
    end
    def edit
        @article = Article.find(params[:id])
    end
    def update
        @article = Article.find(params[:id])
        @article.update(article_params)
        redirect_to @article
    end
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private
    def set_article
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :body)
    end
    def require_same_user
        if !@_current_user.admin  && @_current_user.id != @article.user_id
            redirect_to "/forbidden"
        end
    end

end
