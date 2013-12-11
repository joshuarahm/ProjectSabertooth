class LoginController < ApplicationController
	include LoginHelper
	#The default login page
	def index
        @user = User
	end

    def login
        login_params = params.require(:user).permit!

        email, password = login_params[:email_address], login_params[ :password]
        
        user = get_user(email, password)
        if user != nil
            @status = "Valid"
            token = newNonce(32)
            session[:email_address] = user[:email_address]
            session[:session_token] = hash_password(token, "")
            user[:session_token] = token
			user.save()
        else 
            @status = "Notvalid"
        end

		@user = get_session(session[:email_address], session[:session_token])
    end

    def logout
        user = get_user(email, password)
        if user != nil
            session.delete(:email_address)
            session.delete(:session_token)
        end
    end

	def create
        #Permit access to the entire :user hash
        user = params.require(:user).permit!

        user[:password_salt] = new_salt()
        user[:password_hash] = hash_password(user[:password], user[:password_salt])

        #Get rid of plaintext passwords
        user.delete(:password)
        user.delete(:password_confirmation)

        newUser = User.new(user)
        newUser.save()
	end

end
