module LoginHelper
	def get_session(email_address, session_token)
		if email_address == nil or session_token == nil
			return nil
		end
		login_user = User.where(:email_address=>email_address).first
        if login_user != nil
            if login_user[:email_address] == email_address and login_user[:session_token] == hash_password(Base64.decode64(session_token), "")
                return login_user[:id]
            end
        end
        return nil
	end

    def new_salt()
        salt = ""
        salt << new_nonce(8)
        return Base64.encode64(salt)
    end

    def new_nonce(len)
        nonce = ""
        for i in 0..len
            nonce << rand(256)
        end
        return nonce
    end

    #Takes a plaintext password and a Base64 encoded salt and computes the hash
    def hash_password(password, salt)
        pwHash = Digest::SHA2.new(256) 
        pwHash << password << Base64.decode64(salt)
        return pwHash.to_s
    end

    def get_user(email_address, password)
        possible_user = User.where(:email_address=>email_address).first
        if possible_user == nil
            return nil
        end
        paramPass = hash_password(password, possible_user[:password_salt])
        if paramPass == possible_user[:password_hash]
            return possible_user
        end
        return nil
    end
end
