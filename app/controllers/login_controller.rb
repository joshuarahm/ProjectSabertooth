class LoginController < ApplicationController
	include LoginHelper
	#The default login page
	def index
	end

    def login
        login_params = params.require(:user).permit!

        email, password = login_params[:email_address], login_params[:password]
        
        user = get_user(email, password)
        if user != nil
            @status = "Valid"
            token = new_nonce(32)
            session[:email_address] = user[:email_address]
            session[:session_token] = Base64.encode64(token)
            user[:session_token] = hash_password(token, "")
			user.save()
            @user = user
        else 
            @status = "Notvalid"
            flash[:error] = "Invalid Email and/or Password"
            redirect_to login_index_path
        end
    end

    def logout
        if session.has_key?(:email_address)
            session.delete(:email_address)
            session.delete(:session_token)
        end
		redirect_to root_url
    end

	def create
        #Permit access to the entire :user hash
        user = params.require(:user).permit!
        
        if user[:email_address] == ""
            flash[:error] = "Email address required."
            redirect_to new_login_path
        elsif user[:display_name] == ""
            flash[:error] = "Display name required."
            redirect_to new_login_path
        elsif user[:password] != user[:password_confirmation]
            flash[:error] = "Passwords do not match."
            redirect_to new_login_path
        elsif user[:password].length < 4
            flash[:error] = "Password should be atleast 4 characters long."
            redirect_to new_login_path
        end

        user[:password_salt] = new_salt()
        user[:password_hash] = hash_password(user[:password], user[:password_salt])

        #Get rid of plaintext passwords
        user.delete(:password)
        user.delete(:password_confirmation)

        newUser = User.new(user)
        if newUser.save()
            @create_successful = "success"
        end
	end
end
