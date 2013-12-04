Feature: Ability to navigate the website

    As a user of Project SaberTooth,
    so I can use the site, I would like to be able to
    navigate between all of the main pages

Background: We are on the home page

    Given I am on the home page

Scenario: Can I get to the login page
    When I follow "Login"
    Then I should be on the login page

Scenario: Can I get to the login page from the button
    When I follow "sign in"
    Then I should be on the login page

Scenario: Can I get to the new login page
    When I follow "Sign Up"
    Then I should be on the login/new page

Scenario: Can I get to the about page
    When I follow "About"
    Then I should be on the about page
