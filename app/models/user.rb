class User < ActiveRecord::Base
	validates :email_address, uniqueness: true, presence: true
	validates :password_hash, presence: true
	validates :password_salt, presence: true
#	validate :has_valid_plan


#	def has_valid_plan
#		if plan != nil and (plan < 0 or plan > 3)
#			errors.add( :plan, "should be between 0 and 3, inclusive. (There are only 4 plans")
#		end
#	end
end
