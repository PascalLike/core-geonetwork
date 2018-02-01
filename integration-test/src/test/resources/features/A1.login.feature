Feature: GeoNetwork login
        To check if geonetwork login works properly.
 
 Scenario: Check if geonetwork login works
        # Page loading
        Given I navigate to "{endPointToTest}"
        Then I wait 10 seconds for element having id "signin-dropdown-button" to display
        And I click on element having id "signin-dropdown-button"
        And element having id "inputUsername" should be present
        # Wrong login
        Then I enter "wrongUser" into input field having id "inputUsername"
        And I enter "wrongPassword" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        And element having id "inputUsername" should be present
        # Successful login
        Then I enter "admin" into input field having id "inputUsername"
        And I enter "{adminPassword}" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Logout admin 
        Then I navigate to "{endPointToTest}/signout"
