class DocumentController < ApplicationController
	def index
		if @user_id != nil
			@documents = Document.where(:owner_id=>@user_id)
			if session[:current_doc] != nil
				@current_doc = Document.find(session[:current_doc])
			end
		end
	end
	def show
		session[:current_doc] = params[:id]
		redirect_to document_index_path
	end
end
