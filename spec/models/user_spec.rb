require 'spec_helper'
#require 'User'

describe User do
	it "should require an email address" do
		testUser = User.new
		testUser.valid?().should == false
	end
	it "should require a password at least 5 characters long"
	it "should require a valid plan type"
	it "should accept a display name"
	it "should accept a plan type"
	it "should accept a password hash and salt"
	it "should accept a session token"
end

describe "A User's session" do
	it "should be properly stored in the User model"
	it "should store a hashed token."
end
