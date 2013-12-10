class LoginController < ApplicationController
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

    def newSalt()
        salt = ""
        salt << newNonce(8)
        return Base64.encode64(salt)
    end

    def newNonce(len)
        nonce = ""
        for i in 0..len
            salt << rand(256)
        end
        return nonce
    end

    #Takes a plaintext password and a Base64 encoded salt and computes the hash
    def hashPassword(password, salt)
        pwHash = Digest::SHA2.new(256) 
        pwHash << password << Base64.decode64(salt)
        return pwHash.to_s
    end

    def getUser(emailAddress, password)
        possibleUser = User.where(:emailAddress=>emailAddress).first
        if possibleUser == nil
            print("User not found!")
            return nil
        end
        print(possibleUser)
        paramPass = hashPassword(password, possibleUser[:password_salt])
        if paramPass == possibleUser[:password_hash]
            return possibleUser
        end
        return nil
    end
end
