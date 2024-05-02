class UsersController < ApplicationController
    before_action :require_user, except: [:index, :show, :new, :create]
    before_action :set_user, only: [:show, :update, :edit, :destroy]
    before_action :require_same_user, only: [:edit, :update,:destroy]
    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "User #{@user.username} created succesfully"
            session[:current_user_id] = @user.id
            redirect_to root_path
        else 
            render 'new'
        end
    end

    def new
        redirect_to "/"  if @_current_user
        @user = User.new()
    end
    
    def show
    end

    def edit    
    end

    def update
        @user.update(user_params)
        # flash[:success] = "user data updated succesfully"
        redirect_to @user
    end

    def destroy
        @user.destroy
        flash[:notice] = "User Account along with all his articles are deleted succesfully"
        if !@_current_user.admin?
            session.delete(:current_user_id)
            # Clear the memoized current user
            @_current_user = nil
            redirect_to root_url, status: :see_other
            return
        end
        redirect_to users_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    def set_user
        @user = User.find(params[:id])
    end
    def require_same_user
        if !@_current_user.admin  && @_current_user.id != @user.id
            redirect_to "/forbidden"
        end
    end
end
