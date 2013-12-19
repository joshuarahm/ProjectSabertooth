module ApplicationHelper
    def loggedIn?
        return @user != nil
    end
end
