require 'spec_helper'
require 'base64'
require 'digest'
#require 'User'

describe User do
	it "should require an email address" do
		subject.valid?().should == false
		subject[:email_address] = "test@test.com"
		subject.valid?().should == true
	end
	it "should require a password (and salt)" do
		subject[:email_address] = "test@test.com"
		subject.valid?().should == false
		subject[:password_hash] = "abcdefghijklmnop"
		subject[:password_salt] = "abcd"
		subject.valid?().should == true
	end
	it "should require a valid plan type"
	it "should accept a display name" do
		subject[:display_name] = "bob"
		subject[:display_name].should == "bob"
	end
	it "should accept a session token" do
		subject[:session_token] = "a91dvjsndkfoasdifj"
		subject[:session_token].should == "a91dvjsndkfoasdifj"
	end
end

describe "A User's session" do
	it "should be properly stored in the User model" do
		subject[:email_address] = "test@test.com"
		tmp = Digest::SHA2(256)
		tmp << "testtoken"
		subject[:session_token] = tmp.to_s
		subject[:email_address].should == "test@test.com"
		subject[:session_token].should == tmp.to_s
	it "should store a hashed token."
end
