Feature: GeoNetwork loading
        As admin create users and groups.
 
 Scenario: Create a group and associate two reviewers
 				# Page loading
        Given I navigate to "{endPointToTest}"
 	      Then I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      # Login ad admin
        Then I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "admin" into input field having id "inputUsername"
        And I enter "{adminPassword}" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Load admin group page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/organization/groups"
        And I wait 10 seconds for element having id "gn-btn-group-add" to display
				# Add CucumberTestGroup group
        Then I click on element having id "gn-btn-group-add"
        And I enter "CucumberTestGroup" into input field having id "groupname"
        And I click on element having id "gn-btn-group-save"
        # Load admin users page
        Then I navigate to "{endPointToTest}/srv/eng/admin.console#/organization/users"
        And I wait 10 seconds for element having id "gn-btn-user-add" to display
        # Create user CucumberEditor with editor role for CucumberTestGroup
				Then I click on element having id "gn-btn-user-add"
        And I enter "CucumberEditor" into input field having id "username"
        And I enter "CucumberEditor" into input field having id "gn-user-password"
        And I enter "CucumberEditor" into input field having id "gn-user-password2"
        And I enter "Editor" into input field having name "name"
        And I enter "Cucumber" into input field having name "surname"
        And I enter "editor@cucumber.com" into input field having name "email"
        # --------------------> To do: Add as editor for CucumberTestGroup
        And I click on element having id "gn-btn-user-save"
        And I wait 10 seconds for element having id "gn-btn-user-add" to display
        # Create user CucumberReviewer with reviewer role for CucumberTestGroup
        Then I click on element having id "gn-btn-user-add"
        And I enter "CucumberReviewer" into input field having id "username"
        And I enter "CucumberReviewer" into input field having id "gn-user-password"
        And I enter "CucumberReviewer" into input field having id "gn-user-password2"
        And I enter "Reviewer" into input field having name "name"
        And I enter "Cucumber" into input field having name "surname"
        And I enter "reviewer@cucumber.com" into input field having name "email"
        # --------------------> To do: Add as reviewer for CucumberTestGroup
        And I click on element having id "gn-btn-user-save"
        And I wait 10 seconds for element having id "gn-btn-user-add" to display
 				# Logout admin
        Then I navigate to "{endPointToTest}/signout"
        # Login editor
        Then I navigate to "{endPointToTest}"
 	      And I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      And I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "CucumberEditor" into input field having id "inputUsername"
        And I enter "CucumberEditor" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        Then I navigate to "{endPointToTest}/signout"
        # Login reviewer
        Then I navigate to "{endPointToTest}"
 	      And I wait 10 seconds for element having id "signin-dropdown-button" to display
 	      And I click on element having id "signin-dropdown-button"
        And I wait 10 seconds for element having id "inputUsername" to display
       	And I enter "CucumberReviewer" into input field having id "inputUsername"
        And I enter "CucumberReviewer" into input field having id "inputPassword"
        And I click on element having id "submit-login-button"
        # Logout
        Then I navigate to "{endPointToTest}/signout"
            