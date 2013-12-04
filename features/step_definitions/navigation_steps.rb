require 'uri'
require 'cgi'

Given (/I am on the (.*) page/) do |page|
    visit "/#{page}"
end

When (/I follow "(.*)"/) do |link|
    click_link( link )
end

Then (/I should be on the (.*) page/) do |page_name|
    current_path = URI.parse(current_url).path

    if current_path.respond_to? :should
        current_path.should == "/#{page_name}"
    else
        assert_equal "/#{page_name}", current_path
    end
end
