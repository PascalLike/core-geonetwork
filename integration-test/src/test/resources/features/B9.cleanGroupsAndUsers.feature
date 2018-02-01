Feature: GeoNetwork loading
        Clean up tests
 
 Scenario: Clean up tests
 				# Page loading
        Given I navigate to "{endPointToTest}"
 	      Then I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      # Login ad admin
        Then I click on element having id "signin-dropdown-button"
        Then I wait 10 seconds for element having id "inputUsername" to display
       	Then I enter "admin" into input field having id "inputUsername"
        Then I enter "{adminPassword}" into input field having id "inputPassword"
        Then I click on element having id "submit-login-button"
        # Delete metadata
        Then I navigate to "{endPointToTest}/srv/eng/catalog.edit#/board"
        And I click on link having partial text "Cucumber"
        And I click on element having id "delete-record-link-id"
        And I wait for 2 sec
        And I accept alert 
        Then I wait 5 seconds for element having css "div.alert-success" to display
        # Load admin users page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/organization/users"
        Then I wait 10 seconds for element having id "gn-btn-user-add" to display
        # Remove CucumberEditor
        Then I click on link having partial text "Editor Cucumber"
        Then I click on element having id "gn-btn-user-delete"
        # Remove CucumberReviewer
        Then I click on link having partial text "Reviewer Cucumber"
        Then I click on element having id "gn-btn-user-delete"
        # Load admin group page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/organization/groups"
        Then I wait 10 seconds for element having id "gn-btn-group-add" to display
        # Remove CucumberTestGroup group
        Then I click on link having text "CucumberTestGroup"
        Then I click on element having id "gn-btn-group-delete"
 				# Logout admin
        Then I navigate to "{endPointToTest}/signout"
            