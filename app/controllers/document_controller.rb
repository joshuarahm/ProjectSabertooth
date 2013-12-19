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

    def options_save
        params.permit(:id)
        params.permit(:perms)
        params.require(:perms).permit(:user_id,:read,:write,:share)

        perms = params[:perms] 
        users = User.where( :email_address => perms[:user_id] )
        
        if users.length != 1
            @failed = true
        else
            dperm = DocumentPermissions.new
            dperm.created_at = 0
            dperm.updated_at = 0
            dperm.document_id = params[:id]
            dperm.user_id = users[0].id
            dperm.perms = (perms[:read] << 2) + (perms[:write] << 1) + perms[:share]

            puts("Inserting: " + dperm.attributes.to_s)
            @failed = !(dperm.save())
        end
    end

    def options
        params.permit(:id) 
        if params[:id] != nil
            id = params[:id] ;
            doc_perms_list = DocumentPermissions.where( :document_id => id )
            @hashes = [] ;

            doc_perms_list.each do |perm|
                user = Users.find(perm.user_id)
                hash = { :user=>user.name, :perms=>perm.perms }
                hashes << hash
            end
        end
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
            else
                render :json => {:status=>"Failed" + params[:id].to_s + params[:contents].to_s}
            end
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
