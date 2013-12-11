class ApplicationController < ActionController::Base
	include LoginHelper
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :set_user_state

	def set_user_state
		if session.has_key?(:email_address) and session.has_key?(:session_token)
			@user_id = get_session(session[:email_address], session[:session_token])
			rec = User.find(@user_id)
			@user_id = rec[:id]
			@user_name = rec[:display_name]
		end
	end
end
