Feature: Ability to navegate to other main pages from login page

Background: We are on the login page

    Given I am on the login page

Scenario: Can I get to the home page
    When I follow "Home"
    Then I should be on the home page

Scenario: Can I get to the about page
    When I follow "About"
    Then I should be on the about page

Scenario: Can I get to the new login page
    When I follow "Create an account"
    Then I should be on the login/new page
