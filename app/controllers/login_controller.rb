class LoginController < ApplicationController
	#The default login page
	def index

	end

	def create
        user = params.require(:user).permit!
        user.require(:emailAddress)
        user.permit(:displayName, :password, :password_confirmation)
        print(user[:displayName])
        pwHash = Digest::SHA2.new(256) 
        pwHash << user[:password]
        user.delete(:password)
        user.delete(:password_confirmation)
        user[:password_salt] = ""
        for i in 0..8
            aChar = rand(256)
            pwHash << aChar.chr
            user[:password_salt] <<  aChar
        end
        user[:password_hash] = pwHash.to_s

        print(user)
        newUser = User.new(user)
        newUser.save()

		print("login#new invoked")
	end

    def user_params
        params.require(:user)
    end
end
