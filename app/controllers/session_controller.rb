class SessionController < ApplicationController
    def new
       @user = User.new
    end

    def create
        user = User.find_by(username: params[:username])
        # binding.break
        if user && user.authenticate(params[:password])
            flash[:notice] = "Logged in succesfully"
          # Save the user ID in the session so it can be used in
          # subsequent requests
          session[:current_user_id] = user.id
          redirect_to root_url
        end
      end

    def destroy
        # Remove the user id from the session
        session.delete(:current_user_id)
        # Clear the memoized current user
        @_current_user = nil
        redirect_to root_url, status: :see_other
    end

end