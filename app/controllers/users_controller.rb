class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        # flash[:notice] = "welcome to dashboard #{@user.username}"
        render 'pages/home'
    end

    def new
        @user = User.new()
    end
    
    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        # flash[:success] = "user data updated succesfully"
        redirect_to @user
    end

    def destroy

    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
