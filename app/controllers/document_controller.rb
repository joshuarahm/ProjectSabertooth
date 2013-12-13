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

	def edit
		if @user_id != nil
			params.permit(:id, :contents)
			doc = Document.find(params[:id])
			doc[:content] = params[:contents]
			doc.save()
			render :json => {:status=>"Success" + params[:id].to_s + params[:contents].to_s}
		end
	end
end
