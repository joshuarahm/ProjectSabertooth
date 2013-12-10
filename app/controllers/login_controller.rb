class LoginController < ApplicationController
	include LoginHelper
	#The default login page
	def index
        @user = User
	end

    def login
        loginParams = params.require(:user).permit!

        email, password = loginParams[:emailAddress], loginParams[ :password]
        
        user = getUser(email, password)
        if user != nil
            @status = "Valid"
            token = newNonce(32)
            session[:emailAddress] = user[:emailAddress]
            session[:session_token] = token
            user[:session_token] = token
        else 
            @status = "Notvalid"
        end
    end

    def logout
        user = getUser(email, password)
        if user != nil
            session.delete(:emailAddress)
            session.delete(:session_token)
        end
    end

	def create
        #Permit access to the entire :user hash
        user = params.require(:user).permit!

        user[:password_salt] = newSalt()
        user[:password_hash] = hashPassword(user[:password], user[:password_salt])

        #Get rid of plaintext passwords
        user.delete(:password)
        user.delete(:password_confirmation)

        newUser = User.new(user)
        newUser.save()
	end

end
