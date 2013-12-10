module LoginHelper
    def newSalt()
        salt = ""
        salt << newNonce(8)
        return Base64.encode64(salt)
    end

    def newNonce(len)
        nonce = ""
        for i in 0..len
            nonce << rand(256)
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
