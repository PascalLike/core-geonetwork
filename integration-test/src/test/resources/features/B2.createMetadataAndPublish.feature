Feature: GeoNetwork loading
        Use the editor/reviewer workflow to create and publish a new metadata record ISO19139.
 
 Scenario: Import templates, create ISO19139 metadata and publish it
 				# Page loading
        Given I navigate to "{endPointToTest}"
 	      Then I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      # IMPORT TEMPLATES
 	      # Login as admin
        Then I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "admin" into input field having id "inputUsername"
        And I enter "{adminPassword}" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Import templates
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/metadata"
        And I click on element having id "iso19139"
        And I click on element having id "loadTemplatesButton"
        And I wait 20 seconds for element having css "div.panel-success" to display
 				# Logout admin
        Then I navigate to "{endPointToTest}/signout"
        # CREATE METADATA
        Then I navigate to "{endPointToTest}"
        And I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      # Login as admin (temporary, should use CucumberEditor)
        Then I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "admin" into input field having id "inputUsername"
        And I enter "{adminPassword}" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Create metadata
        Then I navigate to "{endPointToTest}/srv/eng/catalog.edit#/board"
        And I wait 10 seconds for element having id "add-new-record-id" to display
        And I click on element having id "add-new-record-id"
        Then I navigate to "{endPointToTest}/srv/eng/catalog.edit#/create"
        And I click on link having partial text "preferred"
        And I click on element having id "create-new-metadata"
        And I wait 10 seconds for element having id "save-and-close" to display
        Then I clear input field having id "gn-field-57"
        And I enter "Cucumber" into input field having id "gn-field-57"
        And I click on element having id "save-and-close"
        And I wait for 2 sec
        # Logout
        Then I navigate to "{endPointToTest}/signout"
        # PUBLISH METADATA
        # Login as admin (temporary, should use CucumberReviewer)
        Then I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "admin" into input field having id "inputUsername"
        And I enter "{adminPassword}" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Publish metadata
        Then I navigate to "{endPointToTest}/srv/eng/catalog.edit#/board"
        And I click on link having partial text "Cucumber"
        And I wait 5 seconds for element having id "manage-record-button-id" to display
        And I click on element having id "manage-record-button-id"
        And I click on element having id "manage-record-publish-id"
        Then I wait 5 seconds for element having css "div.alert-success" to display
        # Logout
        Then I navigate to "{endPointToTest}/signout"

        
        