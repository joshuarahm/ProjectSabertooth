class DocumentController < ApplicationController
	def index
		if loggedIn?
			@documents = Document.where(:owner_id=>@user[:id])
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
		if loggedIn?
			params.permit(:id, :contents, :title)
            if params[:id] != nil and params[:contents] != nil and params[:title] != nil
                doc = Document.find(params[:id])
                doc[:content] = params[:contents]
                doc[:name] = params[:title]
                doc.save()
                render :json => {:status=>"Success" + params[:id].to_s + params[:contents].to_s}
            end
			render :json => {:status=>"Failed" + params[:id].to_s + params[:contents].to_s}
		end
	end

    def new
        if loggedIn?
            new_doc = Document.new(:owner_id=>@user[:id], :name=>"Untitled Document", :content=>"")
            new_doc.save
            session[:current_doc] = new_doc[:id]
            redirect_to document_index_path
        end
    end
    def destroy
        if loggedIn?
            params.permit(:id)
            doc = Document.find(params[:id])
            if doc != nil
                session.delete(:current_doc)
                doc.destroy
            end
            redirect_to document_index_path
        end
    end
end
