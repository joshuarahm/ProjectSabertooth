Feature: Ability to navegate to other main pages from the about page

Background: We are on the about page

    Given I am on the about page 

Scenario: Can I get to the home page
    When I follow "Home"
    Then I should be on the home page

Scenario: Can I get to the login page
    When I follow "Login"
    Then I should be on the login page

Scenario: Can I get to the new login page
    When I follow "Get Started Now"
    Then I should be on the login/new page
